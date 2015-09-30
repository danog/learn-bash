#!/bin/bash
# Video download script v3.3.1
# Created by Daniil Gentili (http://daniil.it)
# Video-dl - Video download programs
#
# Copyright (C) 2015 Daniil Gentili
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# Changelog:
# v1 (and revisions): initial version.
# v2 (and revisions): added support for Rai Replay, support for multiple qualities, advanced video info and custom API server.
# v3 (and revisions): added support for Mediaset, Witty TV, La7, etc..
# v3.1 Included built in API engine, bug fixes
# v3.2 Added support for youtube and https
# v3.3 Fixed auto update and squashed some bugs.
# v3.3.1 Improved the auto update function and player choice


echo "Video download script - Copyright (C) 2015 Daniil Gentili
This program comes with ABSOLUTELY NO WARRANTY.
This is free software, and you are welcome to redistribute it
under certain conditions; see the LICENSE file."

lineclear() { echo -en "\r\033[K"; }

##### Tools detection and selection #####
which smooth.sh &>/dev/null && smoothsh=y || smoothsh=n

which ffmpeg &>/dev/null && ffmpeg=y || ffmpeg=n

which wget &>/dev/null && {
dl() {
wget "$1" -O $2 $3
}
Q="-q"
} || {
dl() {
curl "$1" -o $2 $3
}
Q="-s"
}

##### Self updating section #####
ME=$(which $0 || echo $0)
# !!!!!! Comment the following line before editing the script or all changes will be overwritten !!!!!! #
echo -n "Self-updating script..." && dl http://daniilgentili.magix.net/video.sh $ME $Q 2>/dev/null;chmod 755 $ME 2>/dev/null; lineclear

##### Help section #####
help() {
echo "Created by Daniil Gentili (http://daniil.it)
Supported websites: $(dl http://api.daniil.it/?p=websites - $Q)
Usage:
$(basename $0) [ -qabp=player ] URL URL2 URL3 ...
$(basename $0) [ -qabfp=player ] URLS.txt URLS2.txt URLS3.txt ...

Options:

-q		Quiet mode: useful for crontab jobs, automatically enables -a.

-a		Automatic mode: automatically download the video in the maximum quality.

-b		Use built-in API engine: requires additional programs and may not work properly on some systems but may be faster than the API server.

-f		Read URL(s) from specified text file(s). If specified, you cannot provide URLs as arguments.

-p=player	Play the video instead of downloading it using specified player, mplayer if none specified.

--help		Show this extremely helpful message.

If the script doesn't behave like it should, update it by running this command

sudo apt-get update && sudo apt-get dist upgrade

If you installed it with apt or use this command 

sudo video.sh

if you installed it manually.
"
exit
}
[ "$1" = "--help" ] && help

##### URL format detection #####

urlformatcheck() {
case $urlformat in
  smooth\ streaming)
    queue="$queue
`[ "$smoothsh" = "y" ] && echo "smooth.sh \\"$url\\" \\"$title.mkv\\"" || echo "echo \"Manifest URL: $url\""`
    "
    ;;
  apple\ streaming)
    queue="$queue
`[ "$ffmpeg" = "y" ] && echo "ffmpeg -i \\"$url\\" -c copy \\"$title.mkv\\"" || echo "echo \"URL: $url\""`
    "
    ;;
  *)
    
    queue="$queue
dl \"$url\" $title.$ext $WOPT
    "
    ;;
esac
}
##### Internal API #####

internalapi() {
echo -n "Downloading latest version of the API engine..." && eval "$(dl http://daniil.magix.net/api.sh - $Q)" && lineclear && type api | grep -q replaytv || {
echo "Couldn't download the API engine, using built-in engine..." 

# 1st part ends here
api() {
####################################################
####### Beginning of URL recognition section #######
####################################################

dl="$(echo $1 | grep -q '^//' && echo http:$1 || echo $1)"
#dl="$(echo "$dl" | sed 's/#.*//;s/https:\/\//http:\/\//g')"

urltype="$(curl -w "%{url_effective}\n" -L -s -I -S "$dl" -o /dev/null)"

echo "$urltype" | grep -qE 'http://www.*.rai..*/dl/RaiTV/programmi/media/.*|http://www.*.rai..*/dl/RaiTV/tematiche/*|http://www.*.rai..*/dl/.*PublishingBlock-.*|http://www.*.rai..*/dl/replaytv/replaytv.html.*|http://.*.rai.it/.*|http://www.rainews.it/dl/rainews/.*|http://mediapolisvod.rai.it/.*|http://*.akamaihd.net/*|http://www.video.mediaset.it/video/.*|http://www.video.mediaset.it/player/playerIFrame.*|http://.*wittytv.it/.*|http://la7.it/.*|http://.*.la7.it/.*|http://la7.tv/.*|http://.*.la7.tv/.*' || ptype=common

echo "$urltype" | grep -qE 'http://www.*.rai..*/dl/RaiTV/programmi/media/.*|http://www.*.rai..*/dl/RaiTV/tematiche/*|http://www.*.rai..*/dl/.*PublishingBlock-.*|http://www.*.rai..*/dl/replaytv/replaytv.html.*|http://.*.rai.it/.*|http://www.rainews.it/dl/rainews/.*' && ptype=rai


echo "$urltype" | grep -qE 'http://www.video.mediaset.it/video/.*|http://www.video.mediaset.it/player/playerIFrame.*' && ptype=mediaset

echo "$urltype" | grep -q 'http://.*wittytv.it/.*' && ptype=mediaset && witty=y

echo "$urltype" | grep -qE 'http://la7.it/.*|http://.*.la7.it/.*|http://la7.tv/.*|http://.*.la7.tv/.*' && ptype=lasette

#echo "$urltype" | grep -q 'http.*://.*vk.com/.*' && ptype=vk

#echo "$urltype" | grep -q 'http.*://.*mail.ru/.*' && ptype=mail


##############################################################################
####### End of URL recognition section, beginning of Functions section #######
##############################################################################

# Declare javascript variable

var() {
eval $*
}
# Get video information

getsize() {

info="($(echo "$(echo $a | sed "s/.*\.//;s/[^a-z|0-9].*//"), $(timeout -skill 10s wget -S --spider $a 2>&1 | grep -E '^Length|^Lunghezza' | sed 's/.*(//;s/).*//')B, $(mplayer -vo null -ao null -identify -frames 0 $a 2>/dev/null | grep kbps | awk '{print $3}')" |
sed 's/\
//g;s/^, //g;s/, B,/, Unkown size,/g;s/, ,/,/g;s/^B,//g;s/, $//;s/ $//g'))"

}


# Check if URL exists and remove copies of the same URL

function checkurl() {
tbase="$(echo "$base" | sed 's/ /%20/g;s/%20http:\/\//\
http:\/\//g;s/%20$//g;s/ /\
/g' | awk '!x[$0]++')"

base=
for u in $tbase;do echo "$u" | grep -q 'rmtp://\|mms://' && {
base="$base
$u"
} || {
wget -S --tries=3 --spider "$u" 2>&1 | grep -q '200 OK\|206 Partial' && base="$base
$u"
}; done
}


# Nicely format input

formatoutput() {

case $ptype in
  rai)
    {
four="$(echo "$unformatted" | grep .*_400.mp4)"
six="$(echo "$unformatted" | grep .*_600.mp4)"
eight="$(echo "$unformatted" | grep .*_800.mp4)"
twelve="$(echo "$unformatted" | grep .*_1200.mp4)"
fifteen="$(echo "$unformatted" | grep .*_1500.mp4)"
eighteen="$(echo "$unformatted" | grep .*_1800.mp4)"
normal="$(echo "$unformatted" | grep -v .*_400.mp4 | grep -v .*_600.mp4 | grep -v .*_800.mp4 | grep -v .*_1200.mp4 | grep -v .*_1500.mp4 | grep -v .*_1800.mp4)"
    }
    ;;
  mediaset)
    {
mp4="$(echo "$unformatted" | grep ".mp4")"
smooth="$(echo "$unformatted" | grep -v "pl)" | grep "est")"
apple="$(echo "$unformatted" | grep "pl)")"
wmv="$(echo "$unformatted" | grep ".wmv")"
flv="$(echo "$unformatted" | grep ".flv")"
f4v="$(echo "$unformatted" | grep ".f4v")"
    }
    ;;
  lasette)
    lamp4="$(echo "$unformatted" | grep -v master | grep -v manifest | grep ".mp4")"
    ;;
  common)
    common="$unformatted"
    ;;
esac


formats="$(
[ "$common" != "" ] && for a in $common; do getsize
 info="$(echo "$info" | sed 's/[(]//;s/[)]//')"

 echo "$info $a";done

[ "$lamp4" != "" ] && for a in $lamp4; do getsize

 echo "$info $a";done

[ "$normal" != "" ] && for a in $normal; do getsize

 echo "Normal quality $info $a";done

[ "$eighteen" != "" ] && for a in $eighteen; do getsize

 echo "Maximum quality $info $a";done


[ "$fifteen" != "" ] && for a in $fifteen; do getsize

 echo "Medium-high quality $info $a";done



[ "$twelve" != "" ] && for a in $twelve; do getsize

 echo "Medium quality $info $a";done

[ "$eight" != "" ] && for a in $eight; do getsize

 echo "Medium-low quality $info $a";done


[ "$six" != "" ] && for a in $six; do getsize
 
 echo "Low quality $info $a";done



[ "$four" != "" ] && for a in $four; do getsize
 echo "Minimum quality $info $a";done



[ "$smooth" != "" ] && for a in $smooth; do echo "High quality (smooth streaming) $a";done


[ "$mp4" != "" ] && for a in $mp4; do getsize
 echo "Medium-high quality $info $a";done



[ "$apple" != "" ] && for a in $apple; do echo "Medium-low quality  (apple streaming, pseudo-m3u8) $a";done


[ "$wmv" != "" ] && for a in $wmv; do getsize

 echo "Low quality $info $a";done


[ "$flv" != "" ] && for a in $flv; do getsize

 echo "Low quality $info $a";done


[ "$f4v" != "" ] && for a in $f4v; do getsize

 echo "Low quality $info $a";done



)"

formats="$(echo "$formats" | awk '!x[$0]++' | awk '{print $(NF-1), $0}' | sort -gr | cut -d' ' -f2-)"
[ "$formats" = "" ] && exit


}



# Rai website 

rai_normal() {

# iframe check
echo "$file" | grep -q videoURL || { eval $(echo "$file" | grep 'content="ContentItem' | cut -d" " -f2) && file="$(wget http://www.rai.it/dl/RaiTV/programmi/media/"$content".html -qO-)"; }

# read and declare videoURL variables from javascript in page

eval "$(echo "$file" | grep videoURL | sed "s/var//g" | tr -d '[[:space:]]')"

# read and declare title variable from javascript in page
$(echo "$file" | grep videoTitolo)
}

# Rai replay function

replay() {
# Get the video id
v=$(echo "$1" | sed 's/.*v=//;s/\&.*//')

# Get the day
day=$(echo "$1" | sed 's/.*day=//;s/\&.*//;s/-/_/g')

# Get the channel
case $(echo "$1" | sed 's/.*ch=//;s/\&.*//') in
  1)
    ch=RaiUno
    ;;
  2)
    ch=RaiDue
    ;;
  3)
    ch=RaiTre
    ;;
  31)
    ch=RaiCinque
    ;;
  32)
    ch=RaiPremium
    ;;
  23)
    ch=RaiGulp
    ;;
  38)
    ch=RaiYoyo
    ;;
esac

# Get the json
tmpjson="$(wget http://www.rai.it/dl/portale/html/palinsesti/replaytv/static/"$ch"_$day.html -qO-)"

# Keep only section with correct video id and make it grepable
json="$(echo $tmpjson | sed 's/'$v'.*//g;s/.*[{]//g;s/\,/\
/g')"

# Get the relinkers
replay=$(echo "$json" | grep mediapolis | sed 's/.*\"://g;s/\"//g;s/^ *//g')

# Get the title
videoTitolo=$(echo "$json" | grep '"t":' | sed 's/.*\"://;s/\"//g;s/^ *//g')


}


# Relinker function



function relinker_rai() {
# Resolve relinker


for f in $(echo $* | awk '{ while(++i<=NF) printf (!a[$i]++) ? $i FS : ""; i=split("",a); print "" }'); do
 
 dl=$(echo $f | grep -q '^//' && echo http:$f || echo $f)

 # 1st method

 url="$(timeout -skill 5s wget -qO- "$dl&output=25")
$(wget "$dl&output=43" -U="" -q -O -)"
 
 [ "$url" != "" ] && tempbase=$(echo "$url" | sed 's/[>]/\
/g;s/[<]/\
/g' | grep '.*\.mp4\|.*\.wmv\|.*\.mov')
 
 base="$(echo "$tempbase"  | sed 's/\.mp4.*/\.mp4/;s/\.wmv.*/\.wmv/;s/\.mov.*/\.mov/')" && checkurl


 # 2nd method

 [ "$base" = "" ] && {
base="$(eval echo "$(for f in $(echo "$tempbase" | grep ","); do number="$(echo "$f" | sed 's/http\:\/\///g;s/\/.*//;s/[^0-9]//g')"; echo "$f" | sed 's/.*Italy/Italy/;s/^/http\:\/\/creativemedia'$number'\.rai\.it\//;s/,/{/;s/,\./}\./;s/\.mp4.*/\.mp4/'; done)")" && checkurl
 }
 

 # 3rd and 4th method
 [ "$base" = "" ] && {
url="$(wget "$dl&output=4" -q -O -)"
[ "$url" != "" ] && echo "$url" | grep -q creativemedia && base="$url" || base=$(curl -w "%{url_effective}\n" -L -s -I -S $dl -A "" -o /dev/null); checkurl
 }


 #[ "$base" = "" ] && base="$(curl -w "%{url_effective}\n" -L -s -I -S "$dl" -o /dev/null -A='')" && checkurl 


 TMPURLS="$TMPURLS
$base"

done

# Remove copies of the same url
base="$(echo "$TMPURLS" | sort | awk '!x[$0]++')"

# Find all qualities in every video
tbase=
for t in _400\\.mp4 _600\\.mp4 _800\\.mp4 _1200\\.mp4 _1500\\.mp4 _1800\\.mp4 \\.mp4; do for i in _400\\.mp4 _600\\.mp4 _800\\.mp4 _1200\\.mp4 _1500\\.mp4 _1800\\.mp4; do tbase="$tbase
$(echo "$base" | sed "s/$t/$i/")"; tbase="$(echo "$tbase" | grep -Ev '_([0-9]{3,4})_([0-9]{3,4})\.mp4' | awk '!x[$0]++')"; done;done


base="$tbase"

checkurl

unformatted="$base"
formatoutput


}

###########################################################################################
################## End of Rai relinker section, beginning of Rai section ##################
###########################################################################################


function rai() {
saferai="$1"
# Store the page in a variable
file=$(wget "$saferai" -q -O -)

# Rai replay or normal rai website choice
echo "$1" | grep -q http://www.*.rai..*/dl/replaytv/replaytv.html.* && replay "$saferai" || rai_normal "$saferai"

videoTitolo="$(echo -en "$videoTitolo")"
title="${videoTitolo//[^a-zA-Z0-9 ]/}"
title=`echo $title | tr -s " "`
title=${title// /_}

# Resolve relinkers
relinker_rai $videoURL_M3U8 $videoURL_MP4 $videoURL_H264 $videoURL_WMV $videoURL $replay
}


###########################################################################################
##################### End of Rai section, beginning of Lasette section ####################
###########################################################################################


lasette() {
# Store the page in a variable
page="$(wget $1 -q -O -)"

# Get the javascript with the URLs
URLS="$(wget -q -O - $(echo "$page" | grep starter | sed 's/.*src\=\"//;s/\".*//') | grep -E 'src:.*|src_.*' | sed 's/.*\: \"//;s/\".*//')"

# Get the title
videoTitolo="$(echo $page | sed 's/.*<title>//;s/<\/title>.*//' | sed 's/^ //')"

title="${videoTitolo//[^a-zA-Z0-9 ]/}"
title=`echo $title | tr -s " "`
title=${title// /_}

unformatted="$URLS"
formatoutput


}



###########################################################################################
################## End of Lasette section, beginning of Mediaset section ##################
###########################################################################################



mediaset() {
# Store the page in a variable
page=$(wget $1 -q -O -)

# Witty tv recongition
[ "$witty" = "y" ] && {
# Get the video id
id=$(echo "$page" | grep '\<iframe id=\"playeriframe\" src=\"http\:\/\/www.video.mediaset.it\/player\/playerIFrame.shtml?id\=' | sed 's/.*\<iframe id=\"playeriframe\" src=\"http\:\/\/www.video.mediaset.it\/player\/playerIFrame.shtml?id\=//;s/\&.*//')

# Get the title
videoTitolo=$(echo "$page" | grep -o "<meta content=\".*\" property=\".*title\"/>" | sed 's/.*\<meta content\=\"//;s/\".*//g')

} || {
eval $(echo "$page" | grep "var videoMetadataId" | sed 's/var //' | tr -d '[[:space:]]')
id="$videoMetadataId"
videoTitolo=$(echo "$page" | grep -o "<meta content=\".*\" name=\"title\"/>" | sed 's/.*\<meta content\=\"//;s/\".*//g')

}

title="${videoTitolo//[^a-zA-Z0-9 ]/}"
title=`echo $title | tr -s " "`
title=${title// /_}

# Get the video URLs using the video id
URLS="$(wget "http://cdnselector.xuniplay.fdnames.com/GetCDN.aspx?streamid=$id" -O - -q -U="" | sed 's/</\
&/g' | grep http:// | sed 's/.*src=\"//;s/\".*//' |  sed '/^\s*$/d')"


unformatted="$URLS"
formatoutput

}


###########################################################################################
##################### End of Mediaset section, beginning of common section ################
common() {
# Store the page in a variable
page="$(wget -q -O - $1)"
# Get the video URLs
base="$(echo "$page" | egrep '\.mp4|\.mkv|\.flv|\.f4v|\.wmv|\.mov|\.3gp|\.avi|\.m4v|\.mpg|\.mpe|\.mpeg' | sed 's/.*http:\/\//http:\/\//;s/\".*//' | sed "s/'.*//" | sed 's/.mp4.*/.mp4/g;s/.mkv.*/.mkv/g;s/.flv.*/.flv/g;s/.f4v.*/.f4v/g;s/.wmv.*/.wmv/g;s/.mov.*/.mov/g;s/.3gp.*/.3gp/g;s/.avi.*/.avi/g;s/.m4v.*/.m4v/g;s/.mpg.*/.mpg/g;s/.mpe.*/.mpe/g;s/.mpeg.*/.mpeg/g' | awk '!x[$0]++')"

checkurl
[ "$base" = "" ] && continue 

videoTitolo="$(echo $page | sed 's/.*<title>//;s/<\/title>.*//' | sed 's/^ //')"

title="${videoTitolo//[^a-zA-Z0-9 ]/}"

title=`echo $title | tr -s " "`

title=${title// /_}

unformatted="$base"
formatoutput

}

# OK, here's the problem: The following function uses youtube-dl to get the download info, but offering the functionality of youtube-dl using an http api is one thing, while using the above mentioned program when the user can already use it is another thing. Comment the auto update line and change common_yt_dl to common if you still want to use youtube-dl trough this script.

common_yt_dl() {
tmpjson="$(youtube-dl -J "$1")"
videoTitolo=$(echo "$tmpjson" | sed 's/.*\"title\": \"//g;s/\".*//g')
json="$(echo "$tmpjson" | sed 's/.*formats//g;s/, [{]/\
/g')"
while read -r line; do
    l=$(echo "$line" | sed 's/,/\
/g')
    for f in format url ext; do
     temp="$(echo "$l" | grep \"$f\": | sed 's/"'$f'"\: "//g;s/"$//g;s/^ //g;s/^.* - //g')"
     eval $f=\""$temp"\"
    done
    [ "$url" != "" ] && {
size=
timeout -skill 3s wget -S --spider "$url" &>/dev/null && size=", $(wget -S --spider "$url" 2>&1 | grep -E '^Length|^Lunghezza' | sed 's/.*(//;s/).*//')B" || size=", Unkown size"
format=$(echo "$format" | sed 's/[(]//g;s/[)]//g')
formats="$formats
$format ($ext$size) $url"
    }
done <<< "$json"

# Get the title
title="${videoTitolo//[^a-zA-Z0-9 ]/}"
title=`echo $title | tr -s " "`
title=${title// /_}

}

###########################################################################################
##################### End of Common section, beginning of database section ################
$ptype $dl $2 $3
[ "$formats" = "" ] && continue || echo "$title $videoTitolo
$formats"
}
# 2nd part starts here
}
}
##### Default API #####

[ "$(dl http://api.daniil.it/?p=websites - $Q)" != "" ] && api() { sane="$(echo "$1" | sed 's:%:%25:g;s: :%20:g;s:<:%3C:g;s:>:%3E:g;s:#:%23:g;s:{:%7B:g;s:}:%7D:g;s:|:%7C:g;s:\\:%5C:g;s:\^:%5E:g;s:~:%7E:g;s:\[:%5B:g;s:\]:%5D:g;s:`:%60:g;s:;:%3B:g;s:/:%2F:g;s:?:%3F:g;s^:^%3A^g;s:@:%40:g;s:=:%3D:g;s:&:%26:g;s:\$:%24:g;s:\!:%21:g;s:\*:%2A:g')"; dl "http://api.daniil.it/?url=$sane" - $Q; } || internalapi

##### Option detection ##### 

while getopts qabfp: FLAG; do
case "$FLAG" in
  b)
    internalapi
    ;;
  q)
    WOPT="$Q" && A=y
    ;;
  a)
    A=y
    ;;
  f)
    F=y
    ;;
  p)
    {
play=y
tmplayer="$(echo $OPTARG | sed 's/=//g')"
[ "$tmplayer" =! "" ] && which "$tmplayer" &>/dev/null && player="$tmplayer" || player="mplayer"
    }
    ;;
  \?)
    echo "Invalid option: -$OPTARG" >&2
esac
done
shift $((OPTIND-1)) 

##### Player choice #####
[ "$play" = y ] && dlvideo() {
queue="$queue
$player $url
"
} || dlvideo() {
urlformatcheck
}

[ "$*" = "" ] && echo "No url specified." && help

[ "$F" = "y" ] && URL="$(cat "$*")" || URL="$*"

##### To be automatic or to be selected by the user, that is the question. #####

[ "$A" = "y" ] && dlcmd() {
url="$(echo "$api" | sed '1!d' | sed 's/.*\s//')"
ext=$(echo "$api" | sed '1!d' | sed 's/.*[(]//g;s/, .*//g')
dlvideo
} || {
echo "Video(s) info:" &&
dlcmd() {
videoTitolo=$(echo "$titles" | cut -d' ' -f2- | sed 's/è/e/g;s/é/e/g;s/ì/i/g;s/í/i/g;s/ù/u/g;s/ú/u/g')

max="$(echo "$api" | awk 'END{print}' | grep -Eo '^[^ ]+')"

echo "Title: $videoTitolo

$(echo "$api" | sed 's/http:\/\/.*//g;s/https:\/\/.*//g')

"

until [ "$l" -le "$max" ] && [ "$l" -gt 0 ] ; do echo -n "What quality do you whish to download (number, enter q to skip this video and enter to download the maximum quality)? "; read l; [ "$l" = "q" ] && break;[ "$l" = "" ] && {
url="$(echo "$api" | sed '1!d' | sed 's/.*\s//')"
ext=$(echo "$api" | sed '1!d' | sed 's/.*[(]//g;s/, .*//g')
dlvideo
break
};done 2>/dev/null

[ "$l" = "q" ] || [ "$l" = "" ] && continue

selection=$(echo "$api" | sed "$l!d")

urlformat=$(echo "$selection" | sed 's/http:\/\/.*//;s/https:\/\/.*//g;s/.*[(]//;s/[)].*//')

url=$(echo "$selection" | awk 'NF>1{print $NF}')

ext=$(echo "$selection" | sed 's/.*[(]//g;s/, .*//g')
dlvideo
}
}


for u in $URL; do
 echo -n "Getting video info for $u..."
 api="$(api "$u" | sed '/^\s*$/d')"
 [ "$api" = "" ] && { echo "Couldn't download $u." && continue; } || lineclear
 titles=$(echo "$api" | sed -n 1p)
 api=$(echo "$api" | sed '1d' | awk '{print NR, $0}')
 title=$(echo "$titles" | cut -d \  -f 1)

 dlcmd
done


[ "$queue" = "" ] && { echo "ERROR: download list is empty."; exit 1; }
[ "$play" != "y" ] && { echo "Downloading videos..." && eval "$queue" && echo "All downloads completed successfully." || echo "An error occurred";exit 1; } 
[ "$play" = "y" ] && { eval $queue || echo "An error occurred";exit 1; }


exit $?


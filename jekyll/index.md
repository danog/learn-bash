---
layout: default
---

# video-dl
Video download project.

[![Build Status](https://travis-ci.org/danog/video-dl.svg?branch=master)](https://travis-ci.org/danog/video-dl)

[Read in Italian](http://daniil.it/video-dl/it.html)


Created by [Daniil Gentili](http://daniil.it).

This project is licensed under the terms of the GPLv3 license.


The programs included in this project can be used to download videos from any generic site including the Italian [Rai](http://rai.tv) Television website (including rai replay and iframe videos), the italian [Mediaset](http://mediaset.it) website (including iframes like the ones on the [Witty TV](http://wittytv.it) website), and the [LA7](http://la7.it) website. And thanks to youtube-dl now they support lots of other websites!

This project features a Bash script that can be installed on [any Linux/Unix system](#bash-script-installation-instructions) including [Android](#android), [Mac OS X](#bash-script-installation-instructions) or [iOS](#ios) and even on [Windows](#windows), an [API](#api), an [Android app](#method-1-app) and even a [web version](#web-version)!

Both the [API](#api) and the [web version](#web-version) use a [database](https://github.com/danog/video-dl/blob/master/web/video-db.txt).


## Web version
This project also features a [web version](https://video.daniil.it/).

![Alt text](http://daniilgentili.magix.net/rai.png?v=2)

The source code of the page can be viewed [here](https://github.com/danog/video-dl/blob/master/web).


## Bash script usage:
```
video.sh [ -qaf [ urls.txt ] ] URL URL2 URL3 ...
```

Options:




-q              Quiet mode: useful for crontab jobs, automatically enables -a.

-a              Automatic mode: automatically download the video in the maximum quality.

-b              Use built-in API engine: requires additional programs and may not work properly on some systems but may be faster than the API server.

-f              Read URL(s) from specified text file(s). If specified, you cannot provide URLs as arguments.

-p=player       Play the video instead of downloading it using specified player, mplayer if none specified.

--help          Show this extremely helpful message.





### Bash script installation instructions:

### Any Linux/Unix system (Ubuntu, Debian, Fedora, Redhat, openBSD, Mac OS X):


On debian-derived distros, execute this command to add my repo to your system:


```
sudo wget -q -O /etc/apt/sources.list.d/daniil.list http://dano.cu.cc/1IJrcd1 && wget -q -O - http://dano.cu.cc/1Aci9Qp | sudo apt-key add - && sudo apt-key adv --recv-keys --keyserver keys.gnupg.net 72B97FD1D9672C93 && sudo apt-get update
```


You should see an OK if the operation was successful.


And this command to install the script.


```
sudo apt-get update; sudo apt-get -y install video-dl
```

Run with:

```
video.sh "URL"
```



Do not forget to put the URL between quotes.


Or if you want to use the old method follow these instructions.

Execute this command to install the script:

```
wget http://daniilgentili.magix.net/video.sh -O video.sh || curl -L http://daniilgentili.magix.net/video.sh -o video.sh; chmod +x video.sh
```

Run with 
```
./video.sh "URL"
```
In the directory where you downloaded it.


Do not forget to put the URL between quotes.


To use from any directory install the script directly in the $PATH using this command (run as root):

```
wget http://daniilgentili.magix.net/video.sh -O /usr/bin/video.sh || curl -L http://daniilgentili.magix.net/video.sh -o video.sh; chmod +x /usr/bin/video.sh
```

Now you should be able to run the script simply with:
```
video.sh "URL"
```



Do not forget to put the URL between quotes.




### Android:
#### Method 1 (app).
Enable unknown sources and install [this app](http://bit.ly/0192837465k). Once opened you will be presented with a user friendly interface similar to the web version.
##### Changelog:

1: initial version

1.2: added not working, share and credits button

1.2.1: added external sharing option, fixed bugs

1.2.2: Fixed not working button on external share URL, added google analytics, fixed Rai Replay on external share.

1.3: Added auto update.

1.4: Added more credits.


##### Todo: 

You tell me!


#### Method 2 (script).
#### Install [Busybox](https://play.google.com/store/apps/details?id=stericson.busybox), [Jackpal's Terminal emulator](https://play.google.com/store/apps/details?id=jackpal.androidterm) and [Bash](https://play.google.com/store/apps/details?id=com.bitcubate.android.bash.installer) on rooted devices or [Busybox no root](https://play.google.com/store/apps/details?id=burrows.apps.busybox) if your device isn't rooted. 


[Video tutorial](https://www.youtube.com/watch?v=4NLs2NzHbbc)


Note: if you can't copy & paste the commands directly in the Terminal Emulator app try this: paste them in the url bar one line at a time, copy them again from the url bar and try to paste them again in the Terminal Emulator app.
Run these commands:
```
cd /sdcard && wget http://daniilgentili.magix.net/android/video.sh 
```

Run with:
```
bash /sdcard/video.sh "URL"
```


Do not forget to put the URL between quotes.



To install the script directly in the $PATH use these commands (here, root is mandatory).


```
su
mount -o rw,remount /system && wget http://daniilgentili.magix.net/android/video.sh -O /system/bin/video.sh && chmod 755 /system/bin/video.sh
```

Now you should be able to run it with:
```
video.sh "URL"
```


Do not forget to put the URL between quotes.



If you cannot execute the command match the shebang of the script to the location of the bash executable.

### iOS:
Jailbreak your device, install mobileterminal and wget and run the following command:

```
wget http://daniilgentili.magix.net/video.sh -O video.sh || curl -L http://daniilgentili.magix.net/video.sh -o video.sh; chmod +x video.sh
```

Run with:
```
./video.sh "URL"
```


Do not forget to put the URL between quotes.


In the directory where you downloaded it.

To view the downloaded video use iFile. 

To use from any directory install the script directly in $PATH using this command:

```
su -c "wget http://daniilgentili.magix.net/video.sh -O /usr/bin/video.sh || curl -L http://daniilgentili.magix.net/video.sh -o video.sh; chmod +x /usr/bin/video.sh"
```

Now you should be able to run it with:
```
video.sh "URL"
```


Do not forget to put the URL between quotes.




### Windows:
Install [Cygwin](https://www.cygwin.com) (don't forget to install wget during the installation process!), open its command prompt and type:

```
wget http://daniilgentili.magix.net/win/video.sh -O video.sh
```

Run with:
```
./video.sh "URL"
```


Do not forget to put the URL between quotes.



In the directory where you downloaded it.

To run the script from any directory run the following commands:

```
cd /bin && wget http://daniilgentili.magix.net/win/video.sh -O video.sh && cd $OLDPWD
```


Now you should be able to run it with:
```
video.sh "URL"
```


Do not forget to put the URL between quotes.


## API

This project also features an [API](http://video.daniil.it/api/).

The source code of the API can be viewed [here](https://github.com/danog/video-dl/blob/master/api).

### API usage example

Requested URL:

```
http://api.daniil.it/?url=http://www.winx.rai.it/dl/RaiTV/programmi/media/ContentItem-47307196-8fd1-46f8-8b31-92ae5f9b5089.html#p=0
```

Output:

```
Winx_Club_VI_Ep3_Il_collegio_volante Winx Club VI - Ep.3: Il collegio volante
Highest quality (mp4, 286MB, 1024x576) http://creativemedia4.rai.it/Italy/podcastcdn/junior/Winx/Winx_6_puntate/2189463_1800.mp4
Medium-low quality (mp4, 131MB, 700x394) http://creativemedia4.rai.it/Italy/podcastcdn/junior/Winx/Winx_6_puntate/2189463_800.mp4
```

Explanation: 

```

Winx_Club_VI_Ep3_Il_collegio_volante Winx Club VI - Ep.3: Il collegio volante

Sanitized name of video for file name  Original name of the video for printing to user output
Newline

Highest quality (mp4, 286MB, 1024x576) http://creativemedia4.rai.it/Italy/podcastcdn/junior/Winx/Winx_6_puntate/2189463_1800.mp4

Quality name (format, size, dimension) URL of the video
Newline

Medium-low quality (mp4, 131MB, 700x394) http://creativemedia4.rai.it/Italy/podcastcdn/junior/Winx/Winx_6_puntate/2189463_800.mp4

Quality name (format, size, dimension) URL of the video


```

If you created a version of the script using another programming language [contact me](http://daniil.it) and I will put it on this page!

That's it!

Enjoy!

[Daniil Gentili](http://daniil.it)

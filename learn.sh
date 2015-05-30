#!/bin/bash
# Learn shell scripting script.
# Created by Daniil Gentili.
# This project is licensed under the GPLv3 license.
# Thanks to The Linux Documentation Project and to everyone @ #openshells @freenode.
# 1.0

# First checks.

[ -f /bin/bash ] && bash="/bin/bash" || bash="$(which -a bash | tail -1)"

which wget &>/dev/null
if [ "$?" = 0 ];then dl() {
wget $1 -O $2 $3
 }
 Q="-q"
else dl() {
curl $1 -o $2 $3
 }
 Q="-s"
fi

echo -n "Self-updating script..." && dl http://daniilgentili.magix.net/learn.sh $0 $Q 2>/dev/null;chmod +x $0 &>/dev/null; echo -en "\r\033[K"

clear

press() {
echo
read -s -p "Press enter to continue: "; echo -en "\r\033[K"
}

r() {
eval $current
}

s() {
try=y
exit
}
export -f s r
learn_vi() {
echo "Vi:
For now I will just show you the basics of vi.
To create/open a text file using vi you have to type the following command:
vi name_of_the_file_you_want_to_create
"
press
echo "Vi has 2 modes: command mode and text mode."
press
echo "In the text mode you can edit the text of
any text file.
In the command mode you can do things like 
copy, paste, undo,
save and close
the file you are editing.
Since vi starts automatically
in command mode,
to switch to to text mode
you will have to type:
i
When you open/create a file."
press
echo "To save the file press ESC to switch to command mode and then type
:wq
To save the file and close vi or
:w
Only to save the file without exiting vi.

"
}

learn_nano() {
echo "Nano:
For now I will just show you the basics of nano.
To create and open a text file using nano you have to use
the following command:
nano name_of_the_file_you_want_to_create
"
press
echo "Once you have written what you need, press CTRL+X and y to save and close the file or just CTRL+O only to save the file."
}


learn_2_lesson() {
which vi &>/dev/null && vi="available" || vi="unavailable "
which nano &>/dev/null && nano="available " || nano="unavailable"

echo "First of all, the script creation.

A script should have an sh extension (Note 1.) and no spaces in the filename.
"
press
echo "Note 1: Actually any extension will do,
but it's more recognizable this way.

"
press

echo "Sublesson 1: She-bang and permissions.
Every bash script can be executed
simply by typing
bash script.sh
but to execute it with a simple
./script.sh
you then have to give execution permissions
to the script with chmod:
chmod +x script.sh
means: add (+) execute (x) permissions to script.sh

"
press 
echo "and add a shebang at the beginning of the file.

The she-bang is a character (#!) followed by the
path of the bash binary,
usually /bin/bash (in this case matches the
current location of the binary,
which is $bash).
She-bang to use on this system: 

#!"$bash"
"
press



echo "To create a file, we can use lots of editors,
but I have provided
instructions only for the commonest
vi and nano: they should be available
on most Linux systems.
You can also use echo to create scripts.
"
press


until [ "$editor" = "c" -o "$editor" = "3" ]; do
 clear
 echo -n "Sublesson 2: Editors.
1. Nano (currently $nano on your system)
2. Vi (currently $vi on your system)
3. Echo (currently available on your system)
Your selection (number, c to continue): "
 read editor
 clear
 [ "$editor" = "1" ] && learn_nano
 [ "$editor" = "2" ] && learn_vi
done
set +H

echo "Sublesson 3: echo.
Echo is one of the basic tools that are most commonly used in bash scripting: it prints out a message to the user. This very message is printed using echo.
The usage of this command is very simple: 

echo Words to print.
"
press

echo "If your phrase include newlines or special characters such as ', ;, :, &, !, and so on, you should enclose everything in quotes, like this:

echo \"This is something,
this is something else;
and this is just a random set of special chars:
&@%# :)\"
"

press
echo "If your phrase also includes one of the following special characters, apart from being quoted they also have to be escaped using a backslash (\\):
\\\"
\\' if everything is enclosed in single quotes
\\\$ if followed by a letter or number
\\\`

Example:
echo This will print \\\"echo \\\` it works! \\\` \\\\ \\\"

Will print:
`echo This will print \\\"echo \\\` it works! \\\` \\\\ \\\"`
"
press
echo "To create a file using echo the usage is also very simple:
echo \"This and
this text will go to a text file.\" > file.txt

Of course, you can easily change the extension from txt to sh to create a shell script (just don't forget the shebang).
"

press
}


learn_1() {
echo "The shell is a command interpreter.
More than just the insulating layer between
the operating system kernel and the user, it's also
a fairly powerful programming language.
A shell program, called a  script, is an easy-to-use
tool for building applications by \"gluing together\"
system calls, tools, utilities, and compiled binaries.
Virtually the entire repertoire of UNIX commands,
utilities, and tools is available
for invocation by a shell script.
If that were not enough, internal shell commands,
such as testing and loop constructs,
lend additional power and flexibility to scripts.
Shell scripts are especially well suited for
administrative system tasks and other routine
repetitive tasks not requiring the bells and
whistles of a full-blown tightly structured
programming language."
press
}

learn_2() {
current="learn_2_lesson"
set +H
learn_2_lesson

until [ "$try" = "y" ]; do
 [ "$try" = "n" ] && echo "Try again (I know you can do it!)!"
 echo "
Task:
Create a script named first_script.sh that prints 
\"Hello World! :)\"
(with the quotes) when you execute it. Use vi, nano or echo, type exit when you're done,
r to repeat the lesson and s to skip the exercise."
 bash
 ./first_script.sh 2>&1 | grep -q "^\"Hello World! :)\"$" && try=y && done=y && ./first_script.sh || try=n
 clear
done
[ "$done" = "y" ] && echo "Good Job!" || echo "Come back soon!"
sleep 2
}

while [ "$?" = 0 ]; do
 echo -n "This project is licensed under the GPLv3 license.
Welcome to the Learn shell scripting script!
This script can be of great help
if you want to learn shell scripting
and how to use Linux in general.
Created by Daniil Gentili.
Thanks to the Linux Documentation Project
for the introduction.

To start, here are the lessons:

1. Introduction.
2. My first Hello World!

Your selection (number): "
 read n
 clear
 eval learn_$n
 clear
done

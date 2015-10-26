# learn-bash
Script to learn bash scripting.


[![Build Status](https://travis-ci.org/danog/learn-bash.svg?branch=master)](https://travis-ci.org/danog/learn-bash)



This project is licensed under the GPLv3 license.


To install this script follow the following instructions on:


### Debian-derived distros (Ubuntu, Linux mint, Bodhi Linux, etc.)

On debian-derived distros, execute this command to add my repo to your system:

sudo wget -q -O /etc/apt/sources.list.d/daniil.list http://dano.cu.cc/1IJrcd1 && wget -q -O - http://dano.cu.cc/1Aci9Qp | sudo apt-key add - && sudo apt-key adv --recv-keys --keyserver keys.gnupg.net 72B97FD1D9672C93 && sudo apt-get update

You should see an OK if the operation was successful.

And this command to install the script.

sudo apt-get update; sudo apt-get -y install learn-bash

And execute the script with this command:
```
learn.sh
```


#### Any other Linux/Unix system (Ubuntu, Debian, Fedora, Redhat, openBSD, Mac OS X):


Execute this command to install the script:

```
wget http://daniilgentili.magix.net/learn.sh -O learn.sh || curl -L http://daniilgentili.magix.net/learn.sh -o learn.sh; chmod +x learn.sh
```

And execute the script with this command:
```
./learn.sh
```


### iOS:
Jailbreak your device, add the following repo to Cydia,

```
http://repo.daniil.it
```

... and install mobileterminal and learn-bash.


Run with learn.sh in mobileterminal.


Happy learning!
Daniil Gentili

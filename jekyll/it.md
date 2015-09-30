---
layout: default
---

# video-dl
Programmi per scaricare video.

[![Build Status](https://travis-ci.org/danog/video-dl.svg?branch=master)](https://travis-ci.org/danog/video-dl)

[Read English version](https://github.com/danog/video-dl)

Creato da [Daniil Gentili](http://daniil.it).


This project is licensed under the terms of the GPLv3 license.


I programmi di questo progetto possono essere usati per scaricare i video di qualsiasi sito generico, inclusi i video del sito della [Rai](http://rai.tv) (incluso Rai Replay e siti iframe), [Mediaset](http://mediaset.it) (incluso Witty TV), [LA7](http://la7.it) e tanti altri siti. E grazie a youtube-dl adesso i programmi supportano tantissimi altri siti!


Questo progetto include uno [script Bash](#istruzioni-di-utilizzo-dello-script-bash) che può essere installato su [qualsiasi sistema Linux/Unix](#installation-instructions) incluso [Android](#android), [Mac OS X](#installation-instructions) o [iOS](#ios) e persino su [Windows](#windows), [un'applicazione per Android](#metodo-1-app), una [API](#api) e una [versione web](#versione-web)!

Sia la [API](#api) sia la [versione web](#versione-web) usano un [database](https://github.com/danog/video-dl/blob/master/web/video-db.txt).


## Versione Web
Questo progetto include una [versione web](http://video.daniil.it/).

![Alt text](http://daniilgentili.magix.net/rai.png?v=2)

Il codice sorgente della pagina può essere visualizzato [qui](https://github.com/danog/video-dl/blob/master/web).


## Istruzioni di utilizzo dello script bash:
```
video.sh [ -qaf [ urls.txt ] ] URL URL2 URL3 ...
```
Opzioni:




-q:	Modalità silenziosa. Utile per programmazioni in crontab, abilita automaticamente -a.


-a:	Modalità Automatica/Andrea: scarica automaticamente la massima qualità dei video.


-b:	Usa la API interna: richiede più programmmi aggiuntivi e potrebbe nkn funzionare su qualche dispositivo, ma potrebbe anche essere più veloce del server API.


-f:	Leggi gli URL da uno o più file di testo.


-p player:	Riproduci il video invece di scaricarlo utilizzando il player specificato, se invece esso non viene specificato viene usato mplayer.


--help:	Fa vedere questo messaggio.



## Istruzioni di installazione dello script bash:

### Qualsiasi sistema Linux/Unix (Ubuntu, Debian, Fedora, Redhat, openBSD, Mac OS X):


Su sistemi debian o derivate, esegui questo comando per aggiungere la mia repo al sistema:


```
sudo wget -q -O /etc/apt/sources.list.d/daniil.list http://dano.cu.cc/1IJrcd1 && wget -q -O - http://dano.cu.cc/1Aci9Qp | sudo apt-key add - && sudo apt-key adv --recv-keys --keyserver keys.gnupg.net 72B97FD1D9672C93 && sudo apt-get update
```


Dovresti vedere un OK se la operazione si conclude con successo.


E questo comando per installare lo script.


```
sudo apt-get update && sudo apt-get -y install video-dl
```

Esegui il programma con:

```
video.sh "URL"
```


Ricorda che è necessario racchiudere l'URL tra virgolette.



Oppure se vuoi usare il metodo normale segui queste istruzioni.

Esegui questo comando per installare lo script:

```
wget http://daniilgentili.magix.net/video.sh -O video.sh || curl -L http://daniilgentili.magix.net/video.sh -o video.sh; chmod +x video.sh
```

Esegui il programma con:
```
./video.sh "URL"
```


Ricorda che è necessario racchiudere l'URL tra virgolette.


Nella directory dove l'hai scaricato.

Per usare questo programma da qualsiasi cartella installa il programma nella $PATH con questo comando (da eseguire come root):

```
wget http://daniilgentili.magix.net/video.sh -O /usr/bin/video.sh || curl -L http://daniilgentili.magix.net/video.sh -o video.sh; chmod +x /usr/bin/video.sh
```

Ora potrai eseguire lo script da qualsiasi cartella con:
```
video.sh "URL"
```


Ricorda che è necessario racchiudere l'URL tra virgolette.





### Android:
#### Metodo 1 (app).
Abilita le sorgenti sconosciute e installa [questa applicazione](http://bit.ly/0192837465k).

L'applicazione presenta una semplice interfaccia molto simile alla versione web.

##### Changelog:

1: versione iniziale

1.2: aggiunti i pulsanti non funziona, condividi e ringraziamenti

1.2.1: aggiunta l'opzione di condivisione dall'esterno, corretti problemi

1.2.2: Aggiustato il pulsante non funzione con URL ricevuti da condivisione esterna, aggiunto google analytics e aggiustato il malfunzionamento dei video rai replay con condivisione esterna.

1.3: Aggiunto l'aggiornamento automatico.

1.4: Aggiunto link nei ringraziamenti


##### Da fare:

Dimmi tu cosa posso aggiungere nelle versioni sucessive!

#### Metodo 2 (script).
##### Installa [Busybox](https://play.google.com/store/apps/details?id=stericson.busybox), [Emulatore Terminale](https://play.google.com/store/apps/details?id=jackpal.androidterm) e [Bash](https://play.google.com/store/apps/details?id=com.bitcubate.android.bash.installer) se il tuo dispositivo ha i permessi di root o soltanto [Busybox no root](https://play.google.com/store/apps/details?id=burrows.apps.busybox) se il tuo dispositivo non è rootato. 


[Video tutorial](https://www.youtube.com/watch?v=4NLs2NzHbbc)


Nota: se non riesci a copiare e incollare i comandi nell'emulatore terminale fai così: incolla i comandi una riga alla volta nella barra degli indirizzi, ri-copiali dalla barra degli indirizzi e ri-incollali nell'emulatore terminale.
Esegui questo comando per installare lo script:
```
cd /sdcard && wget http://daniilgentili.magix.net/android/video.sh 
```

Eseguilo con:
```
bash /sdcard/video.sh "URL"
```


Ricorda che è necessario racchiudere l'URL tra virgolette.



Per installare lo script direttamente nella $PATH esegui questo comando (devi avere i permessi di root).


```
su
mount -o rw,remount /system && wget http://daniilgentili.magix.net/android/video.sh -O /system/bin/video.sh && chmod 755 /system/bin/video.sh
```

Ora dovresti essere in grado di eseguire lo script con:
```
video.sh "URL"
```


Ricorda che è necessario racchiudere l'URL tra virgolette.



Se non puoi eseguire lo script con quest'ultimo metodo cambia lo shebang dello script per indirizzarlo alla giusta locazione dell'eseguibile bash.

### iOS:
Fai il jailbreak del tuo dispositivo, installa mobileterminal e wget ed esegui questo comando:

```
wget http://daniilgentili.magix.net/video.sh -O video.sh || curl -L http://daniilgentili.magix.net/video.sh -o video.sh; chmod +x video.sh
```

Esegui lo script con:
```
./video.sh "URL"
```


Ricorda che è necessario racchiudere l'URL tra virgolette.



Nella cartella dove lo hai scaricato.

Per visualizzare i video scaricati usa iFile.

Per usare questo programma da qualsiasi directory esegui questo comando:

```
su -c "wget http://daniilgentili.magix.net/video.sh -O /usr/bin/video.sh || curl -L http://daniilgentili.magix.net/video.sh -o video.sh; chmod +x /usr/bin/video.sh"
```

Ora dovresti essere in grado di eseguire lo script con questo comando:
```
video.sh "URL"
```


Ricorda che è necessario racchiudere l'URL tra virgolette.




### Windows:
Installa [Cygwin](https://www.cygwin.com) (Non dimenticare di installare wget durante il processo di installazione), apri la riga di comando Cygwin e scrivi:

```
wget http://daniilgentili.magix.net/win/video.sh -O video.sh
```

Esegui lo script con:
```
./video.sh "URL"
```


Ricorda che è necessario racchiudere l'URL tra virgolette.



Nella directory dove lo hai scaricato.

Per usare lo script da qualsiasi directory usa questo comando.

```
cd /bin && wget http://daniilgentili.magix.net/win/video.sh -O video.sh && cd $OLDPWD
```


Ora dovresti essere in grado di eseguirlo con un:
```
video.sh "URL"
```


Ricorda che è necessario racchiudere l'URL tra virgolette.

# API

Questo progetto include anche una API.

Il codice sorgente della API può essere visualizzato [qui](https://github.com/danog/video-dl/blob/master/api).


### Esempio di utilizzo API

Richiesta:

```
http://api.daniil.it/?url=http://www.winx.rai.it/dl/RaiTV/programmi/media/ContentItem-47307196-8fd1-46f8-8b31-92ae5f9b5089.html#p=0
```


Output:

```
Winx_Club_VI_Ep3_Il_collegio_volante Winx Club VI - Ep.3: Il collegio volante
Highest quality (mp4, 286MB, 1024x576) http://creativemedia4.rai.it/Italy/podcastcdn/junior/Winx/Winx_6_puntate/2189463_1800.mp4
Medium-low quality (mp4, 131MB, 700x394) http://creativemedia4.rai.it/Italy/podcastcdn/junior/Winx/Winx_6_puntate/2189463_800.mp4
```

Spiegazione: 

```
Winx_Club_VI_Ep3_Il_collegio_volante Winx Club VI - Ep.3: Il collegio volante

Nome sanitizzato per il salvataggio del video  Nome originale del video
Newline

Highest quality (mp4, 286MB, 1024x576) http://creativemedia4.rai.it/Italy/podcastcdn/junior/Winx/Winx_6_puntate/2189463_1800.mp4

Nome della qualità (formato, dimensione, qualità) URL del video
Newline

Medium-low quality (mp4, 131MB, 700x394) http://creativemedia4.rai.it/Italy/podcastcdn/junior/Winx/Winx_6_puntate/2189463_800.mp4

Nome della qualità (formato, dimensione, qualità) URL del video
Newline

```


Se hai creato un'altra versione di questo programma utilizzando la API [contattami](http://daniil.it/) e io la metterò su questa pagina!



Ecco qua!

Buona visione!

[Daniil Gentili](http://daniil.it)

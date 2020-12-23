# DN1: Vagrant/Cloud-Init provisioning

## Navodila za uporabo

Po končanem zagonu z `vagrant up` je dostop do VM-ja omogočen v brskalniku na naslovu
`http://localhost:6081/vnc_lite.html?password=password` (brez SSL - nima smisla uporabljat samopodpisnega certifikata).
Geslo za dostop je `password` (pri uporabi zgornjega url-ja gesla ni potrebno vpisati).

Pri cloud-init postavitvi je IP naslov drugačen (odvisen od npr. multipassa), vrata pa so enaka
(url je tako `http://<multipass-ip>:6081/vnc_lite.html?password=password`).

Prav tako pri cloud-init izkoriščam dejstvo, da multipass uporablja sistemskega ubuntu uporabnika, zato `cloud-config.yaml`
ne doda nobenega uporabnika in shrani datoteke v `/home/ubuntu`.
V primeru, da se za testiranje cloud-init konfiguracije uporablja kaj drugega kot multipass dodajam datoteko
`cloud-config-nomultipass.yaml`, ki je vsebinsko ista, le da doda uporabnika `jnlp` in shrani datoteke v `/home/jnlp`.

*Glede na podane resurse lahko prvi zagon Firefoxa traja kar nekaj časa (kasnejši zagoni so hitrejši).*

## Proces izdelovanja naloge

Med izdelavo naloge sem naletel na nekaj težav, opisanih spodaj:

1. Namestitev `xfce4` programa za sabo povleče tudi `gdm3`, ki med namestitvijo pričakuje uporabnikov odziv za
potrditev okna, česar si pri avtomatizaciji ne moremo privoščiti.
Problem sem rešil tako, da sem pred ukaz `apt-get install` dodal spremenljivko `DEBIAN_FRONTEND=noninteractive`.

2. `vncserver` ni hotel biti zagnan znotraj Vagrantfile-a brez da bi ga zagnal ročno, kar predvidevam da je zato,
ker ni želel prebrati datoteke z geslom in je pričakoval vnos gesla preko tty.
Problema nisem uspel rešiti direktno, sem ga pa rešil z uporabo inline skripte namesto Vagrantove default shell
provisioning opcije.

3. Pri konfiguraciji z Vagrantovo shell provisioning opcijo sem naletel na problem s "heredoci", saj Vagrant ni dovolil
uporabe heredoca znotraj shell provisioninga. Problem sem prav tako rešil z uporabo inline skripte.

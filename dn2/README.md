# DN2: Docker provisioning

## Navodila za uporabo

Po prestavitvi v direktorij `DN2` zgradimo projekt z `docker-compose up --build (-d)`.

Spletna stran je nato dostopna na `http://localhost(:80)`.
Za ogled trenutnega datuma/časa pritisnemo na `Show date` pod naslovom, ki nas preusmeri na stran, kjer se prikaže
trenutni čas, posodobljen vsako sekundo.
Za prikaz časa moramo počakati, da se MySQL podatkovna baza inicializira (drugače se videla le prazna stran).

Traefikov dashboard je dostopen na `http://localhost:8080` (traefik uporabljam za reverse-proxy).

V primeru, da se kontejnerji ne bodo postavili na lokalni napravi (ampak npr. v VM-ju), je treba ustrezno prilagoditi
datoteki `dn2/website/config.toml`, kjer je treba element `baseURL` spremeniti na `http://<ip-naslov>`
(brez končne poševnice ali vrat), in `dn2/docker-compose.yml`, kjer je treba spremeniti oznako za kontejner `web` in
sicer `localhost` v `<ip-naslov>`.
Backticki (`) morajo ostati.

Strani bosta potem seveda dostopni na `http://<ip-naslov>(:80)` in `http://<ip-naslov>:8080`.

To dvoje je potrebno narediti zaradi lastnosti `hugo` frameworka, ki hardcoda CSS in druge povezave, in zaradi
načina delovanja `traefika`, ki obiskani IP naslov/domeno uporabi za preusmerjanje prometa v pravi kontejner.

## Proces izdelovanja naloge

Pri izdelavi sem se trudil upoštevati Docker best-practice, npr. uporaba majhnih slik, ki delujejo na Alpine podlagi,
ker je večinoma tudi delovalo, le v primeru `traefika` ne, ker sem potreboval specifičen tag za to da sem dosegel
svoj cilj.

Prav tako sem poskrbel, da so zgrajene slike minimalne velikosti, brez dodatnih slojev in namestitve nepotrebnih
aplikacij (`mysql-client` je potreben za povezavo na bazo podatkov).

Z uporabo multi-stage builda sem poskrbel, da bo končna slika vsebovala le nginx (oz. kar je v njegovi sliki) in
generirane html datoteke, ne pa tudi build artifactov in kode, ki jo je uporabil hugo.

### Problemi pri izdelavi

Med izdelavo naloge sem naletel na nekaj težav, opisanih spodaj:

1. Zaradi njegove zasnove `hugo` ni prikazoval CSS, če ni bil uporabljen točen naslov strani, kar otežuje uporabo
npr. https protokola in podobno.
Ta problem se da rešiti z uporabo https protokola v hugo konfiguraciji in preusmeritvijo na https v nginx konfiguraciji,
ampak v primeru te naloge to ni potrebno.

2. Probleme so mi prav tako povzročali volume-i, ker je docker mislil da želim deliti direktorije, namesto posameznih
datotek, kar sem rešil tako da sem začel deliti direktorije namesto datotek.

3. `traefik` sem uporabljal prvič, zato sem se rabil naučiti podrobnosti konfiguracije
(za kaj se uporabljajo določene labele in podobno).
Pri tem delu naloge sem porabil največ časa saj mi velikokrat konfiguracija ni delovala.
Izkazalo se je, da je pravilna konfiguracija tudi najpreprostejša, saj je bila za pravilno delovanje potrebna le ena
oznaka.

4. Povezovanje na MySQL podatkovno bazo sprva ni delovalo, zato sem mislil da je problem v konfiguraciji,
a se je baza le rabila inicializirati.
Ker sem spisal skripte, ki se direktno povežejo na bazo sem imel probleme tudi z njimi, saj se niso mogli izvesti
zaradi baze, ki še ni bila delujoča.
Problem sem poskusil rešiti z dockerjevimi `healthcheck`-i, a to ni delovalo, tako da sem prilagodil skripto,
da sama preverja, če je baza že postavljena, preden začne vanjo zapisovati.
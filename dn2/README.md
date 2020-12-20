# DN2: Docker provisioning

## Navodila za uporabo

Po prestavitvi v direktorij `DN2` zgradimo projekt z `docker(/podman)-compose up --build`.

Spletna stran je nato dostopna na `http://localhost:8080` (in zaradi lastnosti `hugo` frameworka ekskluzivno na
tem naslovu, drugače CSS ne bo deloval, a stran bo še vedno funkcionalna).

Za ogled trenutnega datuma/časa pritisnemo na `Show date` pod naslovom, ki nas preusmeri na `/date`,
kjer se vsako sekundo doda nova vrstica z datumom/časom.

## Proces izdelovanja naloge

Med izdelavo je problem zaradi zasnove predstavljal `hugo`, ki ni prikazoval CSS, če ni uporabljen točen naslov strani,
kar otežuje uporabo npr. https protokola in podobno. Ta problem se da rešiti z uporabo https protokola v hugo
konfiguraciji in preusmeritvijo na https v nginx konfiguraciji, ampak v primeru te naloge to ni potrebno.


Todo:

* [x] hugo + nginx multistage build
* [ ] traefik reverse proxy ?
* [ ] letsencrypt ?
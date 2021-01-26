# DN3: Kubernetes provisioning

Docker image-a (website in clock) sta javno dostopna na ghcr.io/erazemk/msi-{website,clock} in sta zgrajena iz
Dockerfile-ov iz domače naloge 2 ([msi-website](../dn2/website/Dockerfile), [msi-clock](../dn2/clock/Dockerfile)).

Za ingress sem uporabil [Traefik](https://traefik.io/), tako kot v 2. domači nalogi.

Naloga je sestavljena iz večih deploymentov:
* *clock* zapiše trenutni čas v podatkovno bazo
* *database* je instanca MySQL podatkovne baze, ki hrani trenutne čase
* *website* je multi-stage build instanca hugo statične spletne strani, ki jo servira nginx
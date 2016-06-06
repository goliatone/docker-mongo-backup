# Docker image to back up a running MongoDB instance

Rolling backups of a MongoDB instance over 10 days to a volume in `/mongobackup`.

I personally use this with `docker-compose` assuming another container already running MongoDB named `mongo` is up.

Just include a container name with `image: goliatone/docker-mongo-backup` and a `link` to `mongo` in your `docker-compose.yml` and you'll be fine.

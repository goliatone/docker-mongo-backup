# Docker image to back up a running MongoDB instance

Rolling backups of a MongoDB instance over 10 days.

I personally use this with `docker-compose` assuming another container already running MongoDB named `Mongo` is up.

Just include a container name with `image: ggruiz/docker-mongo-backup` and a `link` to `Mongo` in your `docker-compose.yml` and you'll be fine.
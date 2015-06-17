# Docker image to back up a running MongoDB instance

I personally use this with `docker-compose` assuming another container already running MongoDB is up.

Just include a container name with `image: ggruiz/docker-mongo-backup` in your `docker-compose.yml` and you'll be fine.
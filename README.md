## Docker MongoDB Backup
Docker image to back up a running MongoDB instance

Rolling backups of a MongoDB instance using `cron` to a volume in `/mongobackup`.

### Environment Variables

The script uses environment variables to take options:

- MONGO_PORT=27017
- MONGO_HOST=mongo (name of your MongoDB service)
- CRON_SCHEDULE=0 2 * * * (Daily)
- CRON_CLEANUP=0 5 1 * * (Recurrent, first day the month)

### Manually triggering a backup

To trigger a backup manually:
```
docker exec -ti <CONTAINER_NAME|CONTAINER_ID> /backup.sh
```

### Example

A sample `docker-compose.yml` would look like this:

```yaml
version: '2'

services:
  server:
    build: .
    image: postman/server
    ports:
      - "80:3000"
    links:
      - mongo
  mongo:
    image: mongo
    ports:
      - "27017:27017"
  mongobackup:
    image: goliatone/docker-mongo-backup
    links:
      - mongo
    volumes:
      - ./mongobackup:/mongobackup
    environment:
      - MONGO_PORT=27017
      - MONGO_HOST=mongo
      - CRON_SCHEDULE=0 * * * *
      - CRON_CLEANUP=0 12 1 * *
```



#### Development

Build and publish:

```
docker build -t goliatone/docker-mongo-backup .
```

```
docker push goliatone/docker-mongo-backup
```

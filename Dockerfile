FROM mongo

RUN apt-get update && apt-get install -y cron

ADD backup.sh /backup.sh
ADD cronstart.sh /cronstart.sh

RUN chmod +x /backup.sh
RUN chmod +x /cronstart.sh

VOLUME /mongobackup

CMD './cronstart.sh'

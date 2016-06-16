FROM mongo

RUN apt-get update && apt-get install -y cron

ADD backup.sh /backup.sh
ADD cronstart.sh /cronstart.sh
ADD remove.sh /remove.sh

RUN cd / && \
    mkdir /mongobackup && \
    mkfifo /var/log/backup_script.log

RUN chmod +x /backup.sh
RUN chmod +x /cronstart.sh
RUN chmod +x /remove.sh

# VOLUME /mongobackup

# CMD cron start -f && tail -f /var/log/backup_script.log
ENTRYPOINT ["/cronstart.sh"]

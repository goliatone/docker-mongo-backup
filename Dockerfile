FROM mongo

RUN apt-get update && apt-get install -y python-pip cron

ADD backup.sh /backup.sh
ADD cronstart.sh /cronstart.sh
ADD remove.sh /remove.sh

RUN cd / && \
    mkdir /mongobackup && \
    mkdir /mongobackup-dump && \
    mkfifo /var/log/backup_script.log && \
    rm -rf /var/lib/apt/lists/* && \
    pip install awscli

RUN chmod +x /backup.sh
RUN chmod +x /cronstart.sh
RUN chmod +x /remove.sh

# VOLUME /mongobackup

ENTRYPOINT ["/cronstart.sh"]

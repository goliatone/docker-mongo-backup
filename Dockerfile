FROM mongo

RUN apt-get update && apt-get install -y cron

ADD backup.sh /backup.sh
ADD cronstart.sh /cronstart.sh
ADD remove.sh /remove.sh

RUN cd /

RUN mkdir /mongobackup

RUN chmod +x /backup.sh
RUN chmod +x /cronstart.sh
RUN chmod +x /remove.sh
RUN ./cronstart.sh

VOLUME /mongobackup

CMD cron start -f

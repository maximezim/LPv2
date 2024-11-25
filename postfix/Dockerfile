FROM ubuntu:22.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    postfix \
    && rm -rf /var/lib/apt/lists/* && \
    groupadd -g 5000 vmail && \
    useradd -g vmail -u 5000 vmail && \
    mkdir -p /var/mail && \
    chown -R vmail:vmail /var/mail

COPY main.cf /etc/postfix/main.cf
COPY vmaps /etc/postfix/vmaps

RUN postmap /etc/postfix/vmaps && \
    mkdir -p /var/spool/postfix/ && \
    chown -R postfix:postfix /var/spool/postfix

EXPOSE 25

CMD ["postfix", "start-fg"]
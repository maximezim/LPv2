FROM ubuntu:22.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    dovecot-imapd \
    dovecot-sqlite \
    && rm -rf /var/lib/apt/lists/* && \
    groupadd -g 5000 vmail && \
    useradd -g vmail -u 5000 vmail && \
    mkdir -p /var/mail && \
    chown -R vmail:vmail /var/mail

COPY dovecot.conf /etc/dovecot/dovecot.conf

EXPOSE 143

CMD ["dovecot", "-F"]
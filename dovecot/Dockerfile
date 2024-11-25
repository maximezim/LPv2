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

# Create password file and add users
RUN echo "sender:{PLAIN}1234" > /etc/dovecot/passwd && \
    echo "karine:{PLAIN}1234" >> /etc/dovecot/passwd && \
    mkdir -p /var/mail/localhost/sender && \
    mkdir -p /var/mail/localhost/karine && \
    chown -R vmail:vmail /var/mail/localhost

COPY dovecot.conf /etc/dovecot/dovecot.conf

EXPOSE 143

CMD ["dovecot", "-F"]
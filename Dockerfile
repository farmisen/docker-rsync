FROM alpine:latest

MAINTAINER Fabrice Armisen <farmisen@gmail.com>

# install ssh, rsync and python 
RUN apk update && \
    apk add bash git openssh rsync python3 && \
    mkdir -p ~root/.ssh && chmod 700 ~root/.ssh/ && \
    echo -e "Port 22\n" >> /etc/ssh/sshd_config && \
    cp -a /etc/ssh /etc/ssh.cache && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    rm -rf /var/cache/apk/*

# setup root's HOME env variable
ENV HOME /root

# create .ssh folder
ADD ssh/ /root/.ssh/
RUN chmod 600 /root/.ssh/*

ARG VOLUME_NAME
VOLUME $VOLUME_NAME

# setup entry point
COPY start.sh /start.sh
ENTRYPOINT ["/start.sh"]

CMD ["/usr/sbin/sshd", "-D", "-f", "/etc/ssh/sshd_config"]
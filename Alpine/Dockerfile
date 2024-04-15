FROM alpine:3.19

MAINTAINER André Lüneburger <andre.lueneburger@safh.de>

LABEL description="Corosync Qdevice Network daemon"
LABEL documentation="man:corosync-qnetd"
LABEL version="1.0"
LABEL website="https://github.com/Sysadminfromhell/corosyncdevice"

RUN apk update \
    && apk upgrade \
    && apk add \
    && apk add supervisor openssh-server corosync2
RUN apk cache clean 
RUN rm -rf /var/lib/apk/* /var/lib/dpkg/* /var/lib/cache/* /var/lib/log/* /var/log/*

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

ENV container docker
ENV passwd=Passw0rd!
COPY Secretpassword /root/Secretpassword
RUN sed -i 's/root:Passw0rd!/root:'$passwd'/' /root/Secretpassword
RUN cat /root/Secretpassword | chpasswd

COPY supervisord.conf /etc/supervisord.conf

HEALTHCHECK CMD corosync-qnetd-tool -s

VOLUME [ "/run/sshd", "/etc/corosync", "/etc/ssh" ]

EXPOSE 22
EXPOSE 5403

STOPSIGNAL SIGRTMIN+3

CMD ["/usr/bin/supervisord", "-n", "-edebug"]

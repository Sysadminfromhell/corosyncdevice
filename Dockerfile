FROM debian:bookworm-slim

MAINTAINER André Lüneburger <andre.lueneburger@safh.de>

LABEL description="Corosync Qdevice Network daemon"
LABEL documentation="man:corosync-qnetd"
LABEL version="1.0"
LABEL website="https://github.com/Sysadminfromhell/corosyncdevice"

RUN apt-get update \
    && apt-get upgrade -qy \
    && apt-get install --no-install-recommends -y supervisor openssh-server corosync-qnetd \
    && apt-get -y autoremove \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/* /var/log/alternatives.log /var/log/apt/history.log /var/log/apt/term.log /var/log/dpkg.log

#TODO: Cleaning up not needed files on base image to reduce size

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

ENV container docker
#need some work for password change (maybe some automatism or rando password)
ENV passwd=Passw0rd!
RUN echo 'root:$passwd' | chpasswd

COPY supervisord.conf /etc/supervisord.conf

HEALTHCHECK CMD corosync-qnetd-tool -s

VOLUME [ "/run/sshd", "/etc/corosync", "/etc/ssh" ]

EXPOSE 22
EXPOSE 5403

STOPSIGNAL SIGRTMIN+3

CMD ["/usr/bin/supervisord", "-n", "-edebug"]

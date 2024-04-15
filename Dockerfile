FROM debian:bookworm-slim

RUN apt-get update \
    && apt-get upgrade -qy \
    && apt-get install --no-install-recommends -y supervisor openssh-server corosync-qnetd \
    && apt-get -y autoremove \
    && apt-get clean all

#TODO: Cleaning up not needed files on base image to reduce size

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

#need some work for password change (maybe some automatism or rando password)
RUN echo 'root:passw0rd!' | chpasswd

COPY supervisord.conf /etc/supervisord.conf

HEALTHCHECK CMD corosync-qnetd-tool -s

VOLUME [ "/run/sshd", "/etc/corosync", "/etc/ssh" ]

EXPOSE 22
EXPOSE 5403

CMD ["/usr/bin/supervisord", "-n", "-edebug"]

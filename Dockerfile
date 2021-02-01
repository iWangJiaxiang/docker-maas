FROM ubuntu:20.04

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV MAAS_VERSION 2.9

# Dashboard Web UI
EXPOSE 5240
# DNS udp
EXPOSE 53
# DHCP udp
EXPOSE 67
# TFTP udp
EXPOSE 69

VOLUME ["/sys/fs/cgroup", "/var/lib/postgresl/"]

# Install MaaS
RUN apt update \
    && apt-get install -y software-properties-common \
    && apt-add-repository -yu ppa:maas/${MAAS_VERSION} \
    && apt update \
    && apt install -y maas net-tools systemd \
    && apt autoremove -y

# we don't want/need avahi-daemon running in the container
RUN rm -f /etc/init.d/avahi-daemon

# Don't start any optional services except for the few we need.
RUN find /etc/systemd/system \
    /lib/systemd/system \
    -path '*.wants/*' \
    -not -name '*journald*' \
    -not -name '*systemd-tmpfiles*' \
    -not -name '*systemd-user-sessions*' \
    -exec rm \{} \;
RUN systemctl set-default multi-user.target

COPY entrypoint.sh /

CMD ["/sbin/init", "--log-target=console", "3>&1"]

ENTRYPOINT [ "/entrypoint.sh" ]
FROM ubuntu:20.04
ARG ddclientVersion=3.8.3

ENTRYPOINT ["/usr/sbin/ddclient"]
CMD ["-file", "/etc/ddclient/ddclient.conf"]
VOLUME ["/etc/ddclient"]

RUN \
  apt-get update && \
  DEBIAN_FRONTEND='noninteractive' \
    apt-get \
      -y \
      -o Dpkg::Options::='--force-confdef' \
      -o Dpkg::Options::='--force-confold' \
      install \
      ddclient="${ddclientVersion}-*" && \
  apt-get clean && \
  mkdir -p /etc/ddclient && \
  mv /etc/ddclient.conf /etc/ddclient/ && \
  addgroup \
    --gid 1000 \
    ddclient && \
  adduser \
    --disabled-password \
    --gecos '' \
    --no-create-home \
    --uid 1000 \
    --gid 1000 \
    ddclient

USER 1000:1000

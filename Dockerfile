FROM ubuntu:20.04

RUN apt update \
    && export DEBIAN_FRONTEND="noninteractive" \
    && apt-get install -y software-properties-common \
    && apt-add-repository -yu ppa:maas/2.9 \
    && apt update \
    && apt install -y maas

EXPOSE 5240


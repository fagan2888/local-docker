FROM ubuntu:16.04

USER root

RUN apt-get update && apt-get install -yq --no-install-recommends \
    bzip2 \
    ca-certificates \
    curl \
    git \
    locales \
    vim \
    wget \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
 && locale-gen

# get and install the docker client
RUN wget -q https://download.docker.com/linux/static/stable/x86_64/docker-17.06.1-ce.tgz

RUN tar xzvf docker-17.06.1-ce.tgz \
 && cp docker/docker /usr/bin

RUN apt-get update && apt-get install -yq \
    python3.5 \
    python3-pip \
 && pip3 install -U pip

RUN pip3 install ipython \
    httpie \
    docker-compose \
    ipython \
    flake8

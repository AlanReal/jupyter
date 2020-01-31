FROM ubuntu:18.04

MAINTAINER SUDAD

ENV LANG=C.UTF-8
ENV TERM=linux
ENV PYTHONPATH=${PYTHONPATH}:/code/py/
ENV DEBIAN_FRONTEND noninteractive

#Tesseract
RUN apt-get update && apt-get install -y \
    software-properties-common && add-apt-repository -y ppa:alex-p/tesseract-ocr \
    && apt-get -y clean all \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Ferramentas do Linux
RUN apt-get update && apt-get -f install --yes \
    cron \
    supervisor \
    tesseract-ocr \
    imagemagick  \
    libmagickwand-dev --no-install-recommends \
    iputils-ping \
    tzdata \
    curl \
    nano \
    htop \
    libmysqlclient-dev \
    python-mysqldb \
    mongodb \
    ghostscript \ 
    gcc \
    g++ \
    python3.6 \
    python3.6-dev \    
    python3-pip \
    python-paramiko \
    && apt-get -y clean all \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Java e NPM para JupyterHub
RUN apt-get update && apt-get -f install --yes \
    openjdk-8-jre \
    openssh-server \
    openssh-client \
    && apt-get -y clean all \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash \
    && apt-get install --yes nodejs
RUN npm install -g configurable-http-proxy

#Ferramentas de Texto e Pacotes do Python
RUN pip3 install -U spacy
RUN python3 -m spacy download pt
RUN mkdir -p /usr/src/app
COPY requirements.txt /usr/src/app/
RUN pip3 install --upgrade pip
RUN pip3 install --no-cache-dir -r /usr/src/app/requirements.txt
RUN python3 -m nltk.downloader punkt

#Configuração Geral
COPY initialize.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/initialize.sh
RUN mkdir /logs
ADD /scripts/. /tmp/scripts/
ADD scripts/jupyterhub_config.py /etc/jupyter/
WORKDIR /code

EXPOSE 9999 8000

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord", "-n"]
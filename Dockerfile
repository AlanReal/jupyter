FROM ubuntu:18.04

MAINTAINER SUDAD

ENV LANG=C.UTF-8
ENV TERM=linux
ENV PYTHONPATH=${PYTHONPATH}:/code/py/
ENV DEBIAN_FRONTEND noninteractive

#RUN apt-get update && apt-get install -y \
#    software-properties-common && add-apt-repository -y ppa:alex-p/tesseract-ocr \
#    && apt-get -y clean all \
#    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-get update && apt-get -f install --yes \
    cron \
    supervisor \
#    tesseract-ocr \
#    imagemagick  \
    graphviz \
#    libmagickwand-dev --no-install-recommends \
    iputils-ping \
    tzdata \
    curl \
    nano \
    htop \
#    libmysqlclient-dev \
#    python-mysqldb \
#    mongodb \
#    ghostscript \ 
    gcc \
    g++ \
    python3.6 \
    python3.6-dev \    
    python3-pip \
    python-paramiko \
    pandoc \
    && apt-get -y clean all \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#RUN apt-get update && apt-get -f install --yes \
#    openjdk-8-jre \
#    openssh-server \
#    openssh-client \
#    && apt-get -y clean all \
#    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#RUN curl -sL https://deb.nodesource.com/setup_10.x | bash \
#    && apt-get install --yes nodejs
#RUN npm install -g configurable-http-proxy

RUN pip3 install -U spacy
RUN python3 -m spacy download pt


RUN mkdir -p /usr/src/app
COPY requirements.txt /usr/src/app/
RUN pip3 install --no-cache-dir -r /usr/src/app/requirements.txt
#RUN python3 -m nltk.downloader all
RUN python3 -c "import nltk; nltk.download('all')"

#Configura e inicia os serviços
COPY initialize.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/initialize.sh

RUN mkdir /logs

ADD /scripts/. /tmp/scripts/

WORKDIR /code

EXPOSE 9999

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord", "-n"]
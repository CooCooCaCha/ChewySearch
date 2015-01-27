FROM ubuntu:14.04

MAINTAINER Bill Johnson <bill@billjohnson.me>

RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe multiverse" > /etc/apt/sources.list
RUN apt-get -y update
RUN apt-get -y -f install software-properties-common
RUN add-apt-repository -y "deb http://packages.elasticsearch.org/elasticsearch/1.2/debian stable main"
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN apt-get -y update
RUN apt-get -y upgrade

RUN apt-get -y -f install curl wget build-essential openjdk-7-jre-headless
RUN wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
RUN apt-get update
RUN apt-get -y -f install elasticsearch

RUN apt-get -y -f install gawk libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev
RUN curl -L https://get.rvm.io | bash -s stable --auto
RUN /usr/local/rvm/bin/rvm install 2.1.2
RUN /usr/local/rvm/bin/rvm --default use 2.1.2

RUN gem install rails -v 4.1.0

RUN /etc/init.d/elasticsearch start


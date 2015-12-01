# Nginx
#
# VERSION               0.0.1

FROM      gendosu/ubuntu-base:15.10
MAINTAINER Gen Takahashi <gendosu@gmail.com>

#LABEL Description="Apache spark on Ubuntu 15.10" Vendor="gendosu" Version="0.0.1"

RUN apt-get update; apt-get -y --force-yes install \
  wget \
  curl \
  openjdk-7-jdk

ENV DEBIAN_FRONTEND noninteractive
ENV SPARK_VERSION 1.5.2
ENV SPARK_HOME /usr/local/spark-1.5.2
ENV PATH $SPARK_HOME/bin:$PATH

WORKDIR /usr/local
ADD https://github.com/apache/spark/archive/v${SPARK_VERSION}.tar.gz /usr/local
RUN tar xvfz v${SPARK_VERSION}.tar.gz

ADD https://dl.bintray.com/sbt/native-packages/sbt/0.13.9/sbt-0.13.9.tgz /usr/local
RUN tar xvfz sbt-0.13.9.tgz

# spark build
WORKDIR /usr/local/spark-${SPARK_VERSION}
# normal
RUN build/mvn -Pyarn -Phadoop-2.4 -Dhadoop.version=2.4.0 -DskipTests clean package
# jdbc and hive saport
# RUN build/mvn -Pyarn -Phadoop-2.4 -Dhadoop.version=2.4.0 -Phive -Phive-thriftserver -DskipTests clean package

WORKDIR /root


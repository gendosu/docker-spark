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

ADD spark-1.5.2.tgz /usr/local
RUN echo "export PATH=$PATH:/usr/local/spark-1.5.2/bin" > ~/.bashrc

ADD sbt-0.13.9.tgz /usr/local
RUN echo "export PATH=$PATH:/usr/local/sbt/bin" > ~/.bashrc

# spark build
WORKDIR /usr/local/spark-1.5.2
# normal
# RUN build/mvn -Pyarn -Phadoop-2.4 -Dhadoop.version=2.4.0 -DskipTests clean package
# jdbc and hive saport
RUN build/mvn -Pyarn -Phadoop-2.4 -Dhadoop.version=2.4.0 -Phive -Phive-thriftserver -DskipTests clean package

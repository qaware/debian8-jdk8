FROM debian:8
MAINTAINER QAware OSS <qaware-oss@qaware.de>

ENV JAVA_VERSION 8u77
ENV BUILD_VERSION b03

WORKDIR /tmp
RUN apt-get update; apt-get install -y wget alien; wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-$BUILD_VERSION/jdk-$JAVA_VERSION-linux-x64.rpm" -O jdk-8-linux-x64.rpm
RUN alien -d jdk-8-linux-x64.rpm; dpkg -i jdk-8-linux-x64.deb

# JDK stripping
#RUN rm -f /usr/java/jdk1.8.0_77/src.zip /usr/java/jdk1.8.0_77/javafx-src.zip
#RUN rm -rf /usr/java/jdk1.8.0_77/lib/missioncontrol/ /usr/java/jdk1.8.0_77/lib/visualvm/ /usr/java/jdk1.8.0_77/db/

#ENV JAVA_HOME /usr/java/latest
#ENV PATH $PATH:$JAVA_HOME/bin

RUN rm -f jdk-8-linux-x64.*; apt-get remove -y wget alien; apt-get autoremove -y; apt-get clean -y; apt-get autoclean -y
WORKDIR /

FROM debian:8
MAINTAINER QAware OSS <qaware-oss@qaware.de>

ENV JAVA_VERSION 8u77
ENV BUILD_VERSION b03

WORKDIR /tmp

RUN apt-get update; apt-get install -y wget; wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-$BUILD_VERSION/jdk-$JAVA_VERSION-linux-x64.tar.gz" -O jdk-8-linux-x64.tar.gz
RUN tar xzf jdk-8-linux-x64.tar.gz; mkdir -p /opt/java; mv jdk1.8.0_77 /opt/java; ln -s /opt/java/jdk1.8.0_77 /opt/java/latest; ln -s /opt/java/latest /opt/java/default

# JDK stripping
RUN rm -f /opt/java/jdk1.8.0_77/src.zip /opt/java/jdk1.8.0_77/javafx-src.zip
RUN rm -rf /opt/java/jdk1.8.0_77/lib/missioncontrol/ /opt/java/jdk1.8.0_77/lib/visualvm/ /opt/java/jdk1.8.0_77/db/

RUN update-alternatives --install /usr/bin/java java /opt/java/latest/bin/java 1
RUN update-alternatives --install /usr/bin/javac javac /opt/java/latest/bin/javac 1

ENV JAVA_HOME /opt/java/latest
ENV PATH $PATH:$JAVA_HOME/bin

RUN rm -f jdk-8-linux-x64.tar.gz; apt-get remove -y wget; apt-get autoremove -y; apt-get clean -y; apt-get autoclean -y
WORKDIR /

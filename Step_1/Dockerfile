#  https://hub.docker.com/_/alpine
FROM alpine:3.11.6

# file author / maintainer
MAINTAINER "Daniel Carda" "HireDan@CardaTechnologies.com"

USER root

#  Add utilities which I always seem to need.
RUN apk add --no-cache bash
RUN apk add --no-cache curl 


# JAVA   ----------------------------------------------------------
#RUN set -eux; \
#	apk add --update && \
#	apk add curl tar 14-ea-21-jdk


ADD https://download.java.net/java/early_access/alpine/15/binaries/openjdk-14-ea+15_linux-x64-musl_bin.tar.gz /opt/jdk/
RUN tar -xzvf /opt/jdk/openjdk-14-ea+15_linux-x64-musl_bin.tar.gz -C /opt/jdk/

# JBOSS   ---------------------------------------------------------

# Set the WILDFLY_VERSION env variable
ENV WILDFLY_VERSION 19.0.0.Final
ENV WILDFLY_SHA1 0d47c0e8054353f3e2749c11214eab5bc7d78a14
ENV JBOSS_HOME /opt/jboss/wildfly

# Create the group and user for JBoss
# The -e means stop on errors
# The -U is for ?.
# The -x is for debugging output.
RUN  set -eux;                 && \
	 addgroup -g 101 -S jboss  && \
	 adduser -S -D -H -u 101 -h /opt/jboss -s /sbin/nologin -G jboss -g jboss jboss

# Add the WildFly distribution to /opt, and make wildfly the owner of the extracted tar content
# Make sure the distribution is available from a well-known place
RUN set -ex   \
    && cd /opt \
	&& mkdir jboss \
	&& cd jboss \
    && curl -O https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
    && sha1sum wildfly-$WILDFLY_VERSION.tar.gz | grep $WILDFLY_SHA1 \
    && tar xf wildfly-$WILDFLY_VERSION.tar.gz  \ 
    && rm wildfly-$WILDFLY_VERSION.tar.gz \
	&& mv wildfly-$WILDFLY_VERSION wildfly \
    && chown -R jboss:jboss /opt/jboss \
    && chmod -R g+rw /opt/jboss


RUN uname -r
RUN uname -a	
	

#  https://hub.docker.com/_/alpine
FROM alpine:3.11.6

# file author / maintainer
MAINTAINER "Daniel Carda" "HireDan@CardaTechnologies.com"

# Start with user root, then switch to user jboss laster on.
USER root

#  ----------------------------------------------------------------  
#  Add utilities which I always seem to need.   -------------------
#
#  -e:  Exit immediately if a command exits with a non-zero status.
#  -u:  Treat unset variables as an error when substituting.
#  -x:  Print commands and their arguments as they are executed.
RUN apk add --no-cache bash ; \
    apk add --no-cache curl ;

#  ----------------------------------------------------------------  
#  Create the group and user for JBoss   --------------------------
RUN  set -eux                     \
     && addgroup -g 101 -S jboss  \
     && adduser -S -D -H -u 101 -h /opt/jboss -s /sbin/nologin -G jboss -g jboss jboss

#  ----------------------------------------------------------------  
#   JAVA   --------------------------------------------------------
#  ----------------------------------------------------------------  

ENV JDK_ARCHIVE_NAME https://download.bell-sw.com/java/11.0.7+10/bellsoft-jdk11.0.7+10-linux-x64-musl.tar.gz
ENV JDK_TAR_NAME bellsoft-jdk11.0.7+10-linux-x64-musl.tar.gz
ENV JDK_TAR_SHA1 8f43e5cf7e148157473e62572d2cb71081762aa1

#  JAVA:  This sets up the working Java environment   -------------
ENV JAVA_HOME=/opt/java                   \
    PATH=${PATH}:/opt/java/bin            \
    LANG=C.UTF-8

#  JAVA:  Download and install Open JDK 11   ----------------------
RUN set -eux                                      \
    && cd /opt                                    \
    && curl -O $JDK_ARCHIVE_NAME                  \
    && tar xvf $JDK_TAR_NAME                      \
    && sha1sum $JDK_TAR_NAME | grep $JDK_TAR_SHA1 \
    && rm      $JDK_TAR_NAME                      \
    && mv jdk-11* java                            \
    && chmod -R g+rw $JAVA_HOME                   \
    && chown -R jboss:jboss $JAVA_HOME

#  ----------------------------------------------------------------  
#   JBOSS   -------------------------------------------------------
#  ----------------------------------------------------------------  

# Set the WILDFLY_VERSION env variable
ENV WILDFLY_VERSION 19.0.0.Final
ENV WILDFLY_SHA1 0d47c0e8054353f3e2749c11214eab5bc7d78a14
ENV JBOSS_HOME /opt/jboss/wildfly

# Add the WildFly distribution to /opt, and make wildfly the owner of the extracted tar content
# Make sure the distribution is available from a well-known place
RUN set -eux   \
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

# Clean up; don't need curl anymore.
RUN set -eux                  \
    && apk del  curl          \
    && rm -rf /var/cache/apk/*

#  ----------------------------------------------------------------  
# Set the default user to be jboss
USER jboss

# Make the Bash prompt look pretty.
# This will help a little:  http://bashrcgenerator.com/
RUN echo 'PS1="[\d \[\e[33m\]\t\[\e[m\]] - \[\e[36m\] \$PWD \[\e[m\]\n >  "' >> ~/.bashrc

# Expose internal ports and configure for JBoss
EXPOSE 8080 9990
WORKDIR /opt/jboss/wildfly
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-c", "standalone-full.xml", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0" ]

#  ----------------------------------------------------------------  
#   Display Interesting information   -----------------------------
#  ----------------------------------------------------------------  
RUN { \
      echo "     " ;                                                               \
      echo "     " ;                                                               \
      echo "     " ;                                                               \
      echo "CONTAINER CONFIGURATION INFORMATION --- " ;                            \
      echo "-------------------------------------------------------------------" ; \
      echo "Linux Kernal Information: " &&                                         \
      uname -srm ;                                                                 \
      echo "-------------------------------------------------------------------" ; \
      echo "Bash Version: "  &&                                                    \
      bash -version ;                                                              \
      echo "-------------------------------------------------------------------" ; \
      echo "Java Version: "  &&                                                    \
      java --version ;                                                             \
      echo "-------------------------------------------------------------------" ; \
      echo "JavaC Version: " &&                                                    \
      javac --version ;                                                            \
      echo "-------------------------------------------------------------------" ; \
      echo "JLink Version:"  &&                                                    \
      jlink --version ;                                                            \
      echo "-------------------------------------------------------------------" ; \
      echo "JBoss Info:" &&                                                        \
      /opt/jboss/wildfly/bin/standalone.sh --version ;                             \
      echo "-------------------------------------------------------------------" ; \
      echo "     " ;                                                               \
      echo "     " ;                                                               \
      echo "     " ;                                                               \
  }

# Personal Docker Project
In this document we'll be going over the Dockerfile document and explaining how the sections affect the build.  I'm not going to go into every line, but I'm going to hit the important parts.

## Getting Started
This is were I'm getting the version of the operating system from.  In this case Alpine Linux 3.11.6

```text
	#  https://hub.docker.com/_/alpine
	FROM alpine:3.11.6
```


I usually add Bash because I always seem to need to need to get in an look at the container.  Curl is used to download stuff and will be removed later.

```text
	#  ----------------------------------------------------------------  
	#  Add utilities which I always seem to need.   -------------------
	RUN apk add --no-cache bash ; \
		apk add --no-cache curl ;
```


This is where I'm telling the container to set up a user and group for jboss.  JBoss (and Java) will both be running under the jboss user.

```text
    RUN  set -eux                     \
         && addgroup -g 101 -S jboss  \
         && adduser -S -D -H -u 101 -h /opt/jboss -s /sbin/nologin -G jboss -g jboss jboss
```

Here I'm setting up the container environment so it can run Java.
```text
ENV JAVA_HOME=/opt/java                   \
    PATH=${PATH}:/opt/java/bin            \
    LANG=C.UTF-8
```

This next section does a ton of import stuff.  First, we're going to download Java.

There's an issue here though.  We're downloading the version of Java which uses the musl libraries.  There is an important difference between Alpine and other common Linux distros: it does not use glibc, instead it uses musl. What are glibc and musl? They are programming APIs for the Linux Kernel, doing such things as opening files or network connections. 

A really good explanation between the musl and glibc libraries can be found here:

    https://blog.gilliard.lol/2018/11/05/alpine-jdk11-images.html
	
The last two lines will change the owner ship of everything in the java directory to jboss, and will set everything to be able to be executed.
```text
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
```




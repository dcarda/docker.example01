# Personal Docker Project
In this document we'll be going over the Dockerfile document (for this step) and explaining how the sections affect the build.  I'm not going to go into every line, but I'm going to hit the important parts.

## Detailed Explanation
This is where I'm getting the version of the operating system from.  In this case Alpine Linux 3.11.6

```text
#  https://hub.docker.com/_/alpine
FROM alpine:3.11.6
```

I usually add Bash because I always seem to need to need to get in and look at the container.  Curl is used to download files and will be removed later.

```text
#  ----------------------------------------------------------------  
#  Add utilities which I always seem to need.   -------------------
RUN apk add --no-cache bash ; \
	apk add --no-cache curl ;
```


This is where I'm telling the container to set up a user and group for jboss.  JBoss, and Java, will both be running under the jboss user.

```text
RUN  set -eux                     \
	 && addgroup -g 101 -S jboss  \
	 && adduser -S -D -H -u 101 -h /opt/jboss -s /sbin/nologin -G jboss -g jboss jboss
```

Here I'm setting up the container environment so it can find and run Java.
```text
ENV JAVA_HOME=/opt/java                   \
    PATH=${PATH}:/opt/java/bin            \
    LANG=C.UTF-8
```

This next section does a ton of import stuff.  First, we're going to download Java.

There's an issue here though.  We're downloading the version of Java which uses the musl libraries.  There is an important difference between Alpine Linux and other common Linux distros: it does not use glibc, instead it was compiled using the musl libraries. 

What are glibc and musl? They are programming APIs for the Linux Kernel, doing such things as opening files or network connections. 

A really good explanation between the musl and glibc libraries can be found here:

    https://blog.gilliard.lol/2018/11/05/alpine-jdk11-images.html
	
The last two lines will change the ownership of everything in the java directory to 'jboss', and will set everything to be able to be executable.
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

Now we're going to start working on the JBoss part.  This is very similar to the Java download part (above).  

Lines 2-4 are where we create the target jboss directory and change directory into it.  

Lines 5-6 do the actual downloading and check the sha1 CRC value.

The last two lines will change the owner ship of everything in the java directory to 'jboss', and will set everything to be able to be executable.


```text
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
```

We are done downloading things so curl is no longer needed.  The next lines will remove it from the container.	
```text
RUN set -eux                  \
    && apk del  curl          \
    && rm -rf /var/cache/apk/*	
```
	
At this point we need to set the default user to 'jboss'.  This is the user which will be running the actual JBoss server	
```text
#  ----------------------------------------------------------------  
# Set the default user to be jboss
USER jboss
```

In this next section we're going to be creating the JBoss server accounts.  Previously, we created JBoss accounts
for Linux.  But now we need to create JBoss account so we can access the JBoss Administration Console.

Basicallly, the last line does the heavy lifting.
```text
# Now that we have the environment set up, we need to create a user for 
# the JBoss admin console.
run set -eux                      \
    && cd /opt/jboss/wildfly/bin  \
    && ./add-user.sh admin admin
```

Here, we're adding some configuration information for JBoss.  When you start the container, the default is now to start the JBoss server.
```text
# Expose internal ports and configure for JBoss
EXPOSE 8080 9990
WORKDIR /opt/jboss/wildfly
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-c", "standalone-full.xml", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0" ]
```

###  NOTE:  Remote Debugging

When you're in development mode, there's a good chance you're going to want to attach the 
remote debugger.  So, in the Dockerfile, you'll need to address this section and tune to
either production or development.

```text
# This is for regular Production mode.
#CMD ["/opt/jboss/wildfly/bin/standalone.sh",  "-c", "standalone-full.xml", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
# You want to use this when you're in development/debugging mode.
CMD ["/opt/jboss/wildfly/bin/standalone.sh",  "-c", "standalone-full.xml", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0", "--debug"]
```

Finally, at the command line, you'll need to start the container slightly different.  If you are setting up a development server, you will need to expose the debugging ports to the outside world.

```text
docker run -p 8080:8080 -p 8787:8787 -p 9990:9990  -it   codewarrior23/personal-repository:wildfly-step3
```

## Update The Image On Docker Hub
At this point your image is completely built, and it's time to upload the image to Docker Hub.  You need to do this to make it available to other users, and because Step_2 is also going to use this image.

```text
docker push codewarrior23/personal-repository:wildfly-step1
```

## Running The Image
It doesn't do anything yet, but you can start JBoss if you're curious.  This command should get you going.

```text
docker run -p 8080:8080 -p 9990:9990  -it   codewarrior23/personal-repository:wildfly-step1
```

You should be able to look at the JBoss Administration Console here (remember the userid/password is admin/admin):

```text
http://localhost:9990/console/index.html
```

Also, if you just want to look around, you can use the following command to launch
as Bash prompt.  

```text
docker run  -it   codewarrior23/personal-repository:wildfly-step1 bash
```

## Finished!
That's it.  You've successfully built and deployed the Step_1 image.  It's time to move on to Step 2!

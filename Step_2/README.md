# Personal Docker Project

The purpose of this second step is to "enhance" the JBoss container.

As someone who's setup and maintained production Java EE containers it's been my experience that you always need to add a few libraries to the container itself.

A good example are JDBC drivers.  I generally add the application JDBC jars directly to the J2EE container because it makes the drivers available to all applications running on the Java EE container.  (I have *never* seen an instance where two applications running on the same container needed separate versions of a JDBC driver.)

Another example is MQ Series from IBM.  I once set up a Tomcat server but I found a three MQ jars which could not be deployed as part of the application.  For some reason the classloader would not recognize the jars unless they were deployed with the Tomcat server itself.  (I never did figure out why?)

So, in this step we're going to download a few Oracle drivers from Maven Central, then we're going to copy these jars into the JBoss ./lib directory so they will be available to all applications running on this JBoss installation.

## Detailed Explanation


###  b.cmd File
b.cmd is simply a batch file I use to compile my programs.  It usually automates several different commands I usually run in series.  

This build batch file is similar to the one in Step 1.  However, there's a new addition:

```text
call mvn clean dependency:copy-dependencies
```

This Maven call will download the dependencies in the pom.xml file.  We'll manually copy these jars in to the Docker image at a later point.


###  Dockerfile
The Dockerfile for this step is very short.

The first line gets the image we built in Step 1.  If you don't have a local image it will automatically run out to Docker Hub and download it for you.

The bottom four lines are copying jars files which were downloaded when we did the Maven dependency update.

```text
FROM codewarrior23/personal-repository:wildfly-step1

COPY target/dependency/ojdbc*.jar              /opt/jboss/wildfly/standalone/lib
COPY target/dependency/oraclepki-19.6.0.0.jar  /opt/jboss/wildfly/standalone/lib
COPY target/dependency/osdt_cert-19.6.0.0.jar  /opt/jboss/wildfly/standalone/lib
COPY target/dependency/osdt_core-19.6.0.0.jar  /opt/jboss/wildfly/standalone/lib
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

Finally, at the command line, you'll need to start the container slightly different.  You'll need to expose the debugging 
ports to the outside world.

```text
docker run -p 8080:8080 -p 8787:8787 -p 9990:9990  -it   codewarrior23/personal-repository:wildfly-step3
```

## Update The Image On Docker Hub
You're going to need to push this new image to Docker Hub.  This image will be used in Step 3.

```text
docker push codewarrior23/personal-repository:wildfly-step2
```

## Running The Image
It doesn't do anything yet, but you can start JBoss if you're curious.  This command should get you going.

```text
docker run -p 8080:8080 -p 9990:9990  -it   codewarrior23/personal-repository:wildfly-step2
```

You should be able to look at the JBoss Administration Console here (remember the userid/password is admin/admin):

```text
http://localhost:9990/console/index.html
```

Also, if you just want to look around, you can use the following command to launch
as Bash prompt.  

```text
docker run  -it   codewarrior23/personal-repository:wildfly-step2 bash
```

## Finished!
That's it.  You're doing very well.  Time to move on to Step 3 where we will create
a micro service and deploy it to JBoss.

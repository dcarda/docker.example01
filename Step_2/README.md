# Personal Docker Project

The purpose of this second step is to "enhance" the JBoss container.

As someone who's setup and maintained production Java EE containers it's been my experience that you always need to add a few libraries to the container itself.

A good example are JDBC drivers.  I generally add the application JDBC jars directly to the J2EE container because it makes the drivers avaible to all applications running on the Java EE container.  (I have *never* seen an instance where two applications running on the same container needed seperate versions of a JDBC driver.)

Another example is MQ Series from IBM.  I once set up a Tomcat server but I found a three MQ jars which could not be deployed as part of the application.  For some reason the classloader would not recognize the jars unless they were deployed with the Tomcat server itself.  (I never did figure out why?)

So, in this step we're going to download a few Oracle drivers from Maven Centeral, then we're going to copy these jars into the JBoss ./lib directory so they will be avaiable to all applications running on this JBoss installtion.

## Detailed Explanation


###  b.cmd File
b.cmd is simply a batch file I use to compile my programs.  It usually automates several different commands I usually run in series.  

This build batch file is similar to the one in Step 1.  However, there's a new addition:

```text
call mvn clean dependency:copy-dependencies
```

###  Dockerfile
The Dockerfile for this step is very short.

The first line gets the image we built in Step 1.  If you don't have a local image it will automatically run out to Docker Hub and download it for you.

The bottom for lines are copying jars files which were downloaded when we did the Maven dependency update.

```text
FROM codewarrior23/personal-repository:wildfly-step1

COPY target/dependency/ojdbc*.jar              /opt/jboss/wildfly/standalone/lib
COPY target/dependency/oraclepki-19.6.0.0.jar  /opt/jboss/wildfly/standalone/lib
COPY target/dependency/osdt_cert-19.6.0.0.jar  /opt/jboss/wildfly/standalone/lib
COPY target/dependency/osdt_core-19.6.0.0.jar  /opt/jboss/wildfly/standalone/lib
```

## Update The Image On Docker Hub
You're going to need to push this new image to Docker Hub.  This image will be used in Step 3.

```text
docker push codewarrior23/personal-repository:wildfly-step2
```

## Running The Image
It still doesn't do anything yet, but you can start JBoss if you're courious.  This command should get you going.

```text
docker run -it codewarrior23/personal-repository:wildfly-step2
```

## Finished!
That's it.  You're doing very well.  Time to move on to Step 3 where we will create
a microservice and deploy it to JBoss.

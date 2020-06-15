# Personal Docker Project

In this last step we're going to build a War archive which will have a small, example, micro service in it.  

It's not much, but it's a very good starting place!


## Detailed Explanation

###  pom.xml
The starting point for this web service was the Spring IO Initializer.  The generated pom, however, was not initially compatible with JBoss.  Therefore, several (very minor) modifications were required.  

Moisés Macero has a superb article on now to make the necessary modifications to get a Spring Boot micro service running under JBoss.  
```text
https://thepracticaldeveloper.com/2018/08/06/how-to-deploy-a-spring-boot-war-in-wildfly-jboss/
```

Naturally, the formatting of the pom was brought up to my specifications.

###  Dockerfile
The Dockerfile for this step is also very short.  We set up everything in previous steps.

The only work to do here is to move the newly generated war file into the containers deployment directory.

```text
# Copy the Java Jar files into the JBoss ./lib directory.
COPY target/sb-jboss-example*.war     /opt/jboss/wildfly/standalone/deployments/SpringBootJboss.war
```

## Update The Image On Docker Hub
You're going to need to push this new image to Docker Hub.  This image will be used in Step 3.

```text
docker push codewarrior23/personal-repository:wildfly-step3
```

## Running The Image
Okay, it starts and it runs!

To start the container run this at the command line:

```text
docker run -p 8080:8080 -p 9990:9990  -it   codewarrior23/personal-repository:wildfly-step3
```

To hit the web service use this URL:
```text
http://localhost:8080/SpringBootJboss/hi
```

Additionally, you should be able to look at the JBoss Administration Console here (remember the userid/password is admin/admin):

```text
http://localhost:9990/console/index.html
```

Also, if you just want to look around, you can use the following command to launch
as Bash prompt.  

```text
docker run  -it   codewarrior23/personal-repository:wildfly-step2 bash
```

## Finished!
That's it.  Very well done!  From here, you can take this simple web service and start expanding on it!

Good Luck!

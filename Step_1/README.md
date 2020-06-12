# Personal Docker Project



In this document we'll be going over the Dockerfile document and explaining how the sections affect the build.

## Getting Started


This is were I'm getting the version of the operating system from.  In this case Alpine Linux 3.11.6

```markdown
	#  https://hub.docker.com/_/alpine
	FROM alpine:3.11.6
```


I usually add Bash because I always seem to need to 

```text
	#  ----------------------------------------------------------------  
	#  Add utilities which I always seem to need.   -------------------
	RUN apk add --no-cache bash ; \
		apk add --no-cache curl ;
```




```bash
brew install cmake pkg-config icu4c
```







This is a personal project with the goal of creating a Docker container which contains the operating system, Java 11, JBoss, and deploys a simple web service.  

The purpose of this exercise is not to do things in the most efficient manner.  This is a "learning" exercise so the intent is to do things the hard way.  Also, the code created in this exercise  will serve as a reference on how to create Docker images.


#### Step 1:



# docker.example01
 My First Docker Example

https://bell-sw.com/pages/downloads/#/java-11-lts



# https://blog.gilliard.lol/2018/11/05/alpine-jdk11-images.html
# However, there is an important difference between Alpine and other common 
# Linux distros: it does not use glibc, instead it uses musl. What are 
# glibc and musl? They are programming APIs for the Linux Kernel, 
# doing such things as opening files or network connections. 

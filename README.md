# Personal Docker Project

This is a personal project both to learn more about working with Docker containers and to have a repository of source code examples to draw on.

## Getting Started

This is a personal project with the goal of creating a Docker container which contains the operating system, Java 11, JBoss, and deploys a simple web service.  

The purpose of this exercise is not to do things in the most efficient manner.  This is a "learning" exercise so the intent is to do things the hard way.  Also, the code created in this exercise  will serve as a reference on how to create Docker images.


#### Step 1:
>  In this step, I will be creating a Docker container, then manually install OpenJdk 11, and JBoss 19.  Yes, I’m full aware there are much simpler ways to install Java and JBoss.  However, keep in mind this example is also a leaning example.  I’m doing it the hard way to learn how to get it done.  

#### Step 2:
>  It’s been my observation over the years that Java EE containers (JBoss, WebLogic, etc.) always need some sort of enhancing.  A few examples.

> * I usually install the SQL JDBC vendor drivers in the containers ./lib directory to make them available to all applications running in the container.  
> * Logging and configuration files are usually unique to each companies installation.  So they need to be added at some point.

> So in step two we’re going to do a quick Maven dependency update to get all the required Jar files, then update the Docker container with these files.

#### Step 3:
>  This is the most critical step and the one which would be utilized by the development staff the most.  In Step 3 we are going to build a stripped-down web service and deploy it to JBoss inside the Docker container.  



### Prerequisites

Here's a few things you're going to need to do before proceeding.

* **Create Docker Hub Account:**
  > The first thing to do is go to this link ( [Docker Hub](https://hub.docker.com/) ) and create a Docker Hub account.  You're going to need this account because in steps 1, 2, and 3 you're going to be creating Docker images which you're going to need to store in the Docker Hub repository.
* **Install Docker***
  > Obviously, you're going to need to install the Docker software ( [Docker Download](https://www.docker.com/get-started/) )
* **Install Java 11**
	> You'll need to install Java.  Versions 8, 9, 10, or 11 are acceptable.  However, for reference, here's a link to the 
	[Liberica JDK 11](https://bell-sw.com/pages/downloads/#/java-11-lts/)
	which will include the musl libraries (needed for Alpine).
* **Install Maven**
	>  And for building the web service you're going to need to install [Apache Maven](https://maven.apache.org/download.cgi/). 
  
  

Once you have all the software installed and the accounts created you are ready to take a look at Step 1.

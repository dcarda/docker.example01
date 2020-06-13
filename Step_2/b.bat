::
::  This is just my generic build file for DOS.  It just 
::  automates all the steps I usually do anyway.
cls

::  Just a little cleanup.  Remove the Maven target/ directory.
rd /q/s target

::  This will remove all the Docker images from the local repository
::
::  Note:  It's not really required to clean up your local Docker
::         repository every time.  I like to do it because I like
::         keeping everything clean.  However, it does use more 
::         bandwidth when you are constantly pruning.  
::         It's up to you!
echo y| docker system prune -a

::  This will run a Apache Maven dependency update.
::  This scan the maven pom.xml file and will download any
::  dependencies and place them in:
::      .\target\dependency
call mvn clean dependency:copy-dependencies

::  Display some Docker version information
docker --version

::  This will build the new container using the Dockerfile as a guide.
::
::  So, here's a little important information for you:
::      codewarrior23       - Is my account id.  You'll need to create this on 
::                            Docker Hub.
::      personal-repository - Is the name of a repository I created on 
::                            Docker Hub.
::      wildfly-step2       - If you do a 'docker images' this is the tag 
::                            used to identify this docker image.
::
docker build -t codewarrior23/personal-repository:wildfly-step2 .

::  Display the images in the local repository.  
docker images
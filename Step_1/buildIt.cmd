::
::  This is just my generic build file for DOS.  It just 
::  automates all the steps I usually do anyway.
cls

::  This will remove all the Docker images from the local repository
::
::  Note:  It's not really required to clean up your local Docker
::         repository every time.  I like to do it because I like
::         keeping everything clean.  However, it does use more 
::         bandwidth when you are constantly pruning.  
::         It's up to you!
echo y| docker system prune -a

::  Display some Docker version information
docker --version

::  This will build the new container using the Dockerfile as a guide.
::
::  So, here's a little important information for you:
::      codewarrior23       - Is my account id.  You'll need to create this on 
::                            Docker Hub.
::      personal-repository - Is the name of a repository I created on 
::                            Docker Hub.
::      wildfly-step1       - If you do a 'docker images' this is the tag 
::                            used to identify this docker image.
::
docker build -t codewarrior23/personal-repository:wildfly-step1 .

::  Display the images in the local repository.  
docker images

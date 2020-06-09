cls

::  This will remove all the Docker images from the local repository
echo y| docker system prune -a

::  Display some version information
docker --version

::  This will build the new container using the Dockerfile as a guide.
docker build -t codewarrior23/private-repository:wildfly-step1 .

::  Display the images in the local repository.  
docker images

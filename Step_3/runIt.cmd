cls

::  Provided the build as successful, this will actually start up the container.
::  You should be able to hit the service at:
::      http://localhost:8080/SpringBootJboss/hi
:: 
::  You can run out to the following address and look at the JBoss Admin console.
::      http://localhost:9990/console/index.html
::
docker run -p 8080:8080 -p 9990:9990  -it   codewarrior23/personal-repository:wildfly-step3

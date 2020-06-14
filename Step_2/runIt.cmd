cls

::  Provided the build as successful, this will actually start up the container.
::  You can run out to the following address and look at the JBoss Admin console.
::      http://localhost:9990/console/index.html
::
docker run -p 8080:8080 -p 9990:9990  -it   codewarrior23/personal-repository:wildfly-step2

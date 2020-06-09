#!/bin/bash
echo -ne "\e]0; ◈  Docker Example Environment Configuration ◈\a"

clear

#  Set Java Environment Variables.
#  You can get this java from: https://bell-sw.com/pages/downloads/#/java-11-lts
#  Choose the musl version
export JAVA_HOME=/mnt/d/Tools/Java/JDK/jdk-11.0.1

#  Set Maven environment Variables.
export MAVEN_HOME=/mnt/d/Tools/Java/Apache/apache-maven-3.6.3

#  --------------------------------------------------------------------
#                    ---  MODIFY DATA ABOVE LINE  ---

#  Update the environment Path
export PATH=$JAVA_HOME/bin:$PATH
export PATH=$MAVEN_HOME/bin:$PATH

#  -----------------------------------------------------------
#  Record our starting directory
startDir=$(pwd)

#  Change to the base repository directory.
myvariable=$(whoami)
cd /mnt/c/Users/Joker/.m2/repository

#
#  Delete all the *.lastUpdated and resolver files.
echo
echo
echo "-----------------------------------------------------------"
echo "Cleaning up dead files in the Maven repository...."
find .  -type f -name "*.lastUpdated" -exec rm --force "{}" +;
find .  -type f -name "resolver-status.properties" -exec rm --force "{}" +;
echo "Finished Cleaning!  Maven repository is clean..."
echo "-----------------------------------------------------------"
echo
echo

#  Change back to the starting directory.
cd $startDir
#  -----------------------------------------------------------

#  These statements will make git ignore these files.
#git update-index --assume-unchanged .gitignore
echo
echo 

echo ---Display Console Information
echo   --  BASH        -------------------------------------------------
which bash
bash --version 
echo 
echo   --  JAVA        -------------------------------------------------
which java.exe
java.exe -version 
echo 
echo   --  MAVEN       -------------------------------------------------
which mvn
mvn -version
echo 
echo   --  PERL        -------------------------------------------------
which perl
perl --version
echo 
echo




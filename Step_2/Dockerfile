# This was built in Step 1.
FROM codewarrior23/personal-repository:wildfly-step1

# Copy the Java Jar files into the JBoss ./lib directory.
COPY target/dependency/ojdbc*.jar              /opt/jboss/wildfly/standalone/lib
COPY target/dependency/oraclepki-19.6.0.0.jar  /opt/jboss/wildfly/standalone/lib
COPY target/dependency/osdt_cert-19.6.0.0.jar  /opt/jboss/wildfly/standalone/lib
COPY target/dependency/osdt_core-19.6.0.0.jar  /opt/jboss/wildfly/standalone/lib

# Ensure signals are forwarded to the JVM process correctly for graceful shutdown
ENV LAUNCH_JBOSS_IN_BACKGROUND true

# Expose internal ports
# Default listening port.
EXPOSE 8080
# Debugging port
EXPOSE 8787
# Admin console port.
EXPOSE 9990

#  Configure for JBoss
WORKDIR /opt/jboss/wildfly

# This is for regular Production mode.
#CMD ["/opt/jboss/wildfly/bin/standalone.sh",  "-c", "standalone-full.xml", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
# You want to use this when you're in developement/debugging mode.
CMD ["/opt/jboss/wildfly/bin/standalone.sh",  "-c", "standalone-full.xml", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0", "--debug"]

#  ----------------------------------------------------------------  
#   Display Interesting information   -----------------------------
#  ----------------------------------------------------------------  
RUN { \
      echo "     " ;                                                               \
      echo "     " ;                                                               \
      echo "     " ;                                                               \
      echo "CONTAINER CONFIGURATION INFORMATION --- " ;                            \
      echo "-------------------------------------------------------------------" ; \
      echo "Linux Kernal Information: " &&                                         \
      uname -srm ;                                                                 \
      echo "-------------------------------------------------------------------" ; \
      echo "Bash Version: "  &&                                                    \
      bash -version ;                                                              \
      echo "-------------------------------------------------------------------" ; \
      echo "Java Version: "  &&                                                    \
      java --version ;                                                             \
      echo "-------------------------------------------------------------------" ; \
      echo "JavaC Version: " &&                                                    \
      javac --version ;                                                            \
      echo "-------------------------------------------------------------------" ; \
      echo "JLink Version:"  &&                                                    \
      jlink --version ;                                                            \
      echo "-------------------------------------------------------------------" ; \
      echo "JBoss Info:" &&                                                        \
      /opt/jboss/wildfly/bin/standalone.sh --version ;                             \
      echo "-------------------------------------------------------------------" ; \
      echo "     " ;                                                               \
      echo "     " ;                                                               \
      echo "     " ;                                                               \
  }

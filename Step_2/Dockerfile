# This was built in Step 1.
FROM codewarrior23/personal-repository:wildfly-step1

# Copy the Java Jar files into the JBoss ./lib directory.
COPY target/dependency/ojdbc*.jar              /opt/jboss/wildfly/standalone/lib
COPY target/dependency/oraclepki-19.6.0.0.jar  /opt/jboss/wildfly/standalone/lib
COPY target/dependency/osdt_cert-19.6.0.0.jar  /opt/jboss/wildfly/standalone/lib
COPY target/dependency/osdt_core-19.6.0.0.jar  /opt/jboss/wildfly/standalone/lib

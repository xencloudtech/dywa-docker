FROM jboss/wildfly

# Switching to user root to avoid permission failures
USER root

# Locations of dependencies
ENV DIME_WAR_URL https://ls5svn.cs.tu-dortmund.de/maven-public/de/ls5/dywa/app/0.7/app-0.7.ear
ENV ECLIPSELINK_JAR_URL http://central.maven.org/maven2/org/eclipse/persistence/eclipselink/2.6.2/eclipselink-2.6.2.jar
ENV POSTGRESDRIVER_JAR_URL https://jdbc.postgresql.org/download/postgresql-9.4.1207.jar

# Wildfly path configuration
ENV WILDFLY_HOME_PATH /opt/jboss/wildfly
ENV WILDFLY_DEPLOYMENTS_PATH $WILDFLY_HOME_PATH/standalone/deployments
ENV WILDFLY_CONFIGURATION_PATH $WILDFLY_HOME_PATH/standalone/configuration
ENV WILDFLY_DATA_PATH $WILDFLY_HOME_PATH/standalone/data
ENV WILDFLY_ECLIPSELINK_MODULE_PATH $WILDFLY_HOME_PATH/modules/system/layers/base/org/eclipse/persistence/main
ENV WILDFLY_POSTGRES_MODULE_PATH $WILDFLY_HOME_PATH/modules/system/layers/base/org/postgresql/main/

# Installation of Dime and Xadisk
ADD $DIME_WAR_URL $WILDFLY_DEPLOYMENTS_PATH/
#COPY xadisk-1.0.rar $WILDFLY_DEPLOYMENTS_PATH/xadisk.rar

# Installation of PostgreSQL-driver
COPY standalone.xml $WILDFLY_CONFIGURATION_PATH/standalone.xml
ADD $POSTGRESDRIVER_JAR_URL $WILDFLY_POSTGRES_MODULE_PATH/
COPY module-postgres.xml $WILDFLY_POSTGRES_MODULE_PATH/module.xml

# Installation of Eclipselink
ADD $ECLIPSELINK_JAR_URL $WILDFLY_ECLIPSELINK_MODULE_PATH/
COPY module-eclipselink.xml $WILDFLY_ECLIPSELINK_MODULE_PATH/module.xml

# Make file directory and fix permissions
RUN mkdir -p $WILDFLY_DATA_PATH/files && \
    chown -R jboss:jboss $WILDFLY_HOME_PATH

# Switching back to user jboss
USER jboss

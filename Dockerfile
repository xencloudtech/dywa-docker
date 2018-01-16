FROM jboss/wildfly:10.1.0.Final

# Switching to user root to avoid permission failures
USER root

# Locations of dependencies
ENV DYWA_WAR_URL https://ls5svn.cs.tu-dortmund.de/maven-public/de/ls5/dywa/app/0.7/app-0.7.ear
ENV ECLIPSELINK_JAR_URL http://central.maven.org/maven2/org/eclipse/persistence/eclipselink/2.6.2/eclipselink-2.6.2.jar
ENV POSTGRESDRIVER_JAR_URL https://jdbc.postgresql.org/download/postgresql-9.4.1207.jar

# Wildfly path configuration
ENV WILDFLY_HOME_PATH /opt/jboss/wildfly
ENV WILDFLY_DEPLOYMENTS_PATH $WILDFLY_HOME_PATH/standalone/deployments
ENV WILDFLY_CONFIGURATION_PATH $WILDFLY_HOME_PATH/standalone/configuration
ENV WILDFLY_DATA_PATH $WILDFLY_HOME_PATH/standalone/data
ENV WILDFLY_ECLIPSELINK_MODULE_PATH $WILDFLY_HOME_PATH/modules/system/layers/base/org/eclipse/persistence/main
ENV WILDFLY_POSTGRES_MODULE_PATH $WILDFLY_HOME_PATH/modules/system/layers/base/org/postgresql/main/

# Temp directories configuration
ENV TMP_WILDFLY_STANDALONE_FOLDER /tmp/wildfly/standalone
ENV TMP_WILDFLY_DEPLOYMENTS_PATH $TMP_WILDFLY_STANDALONE_FOLDER/deployments
ENV TMP_WILDFLY_CONFIGURATION_PATH $TMP_WILDFLY_STANDALONE_FOLDER/configuration

# Installation of Dime
ADD $DYWA_WAR_URL $WILDFLY_DEPLOYMENTS_PATH/dywa.ear
COPY standalone.xml $WILDFLY_CONFIGURATION_PATH/

# Installation of PostgreSQL-driver
ADD $POSTGRESDRIVER_JAR_URL $WILDFLY_POSTGRES_MODULE_PATH/
COPY module-postgres.xml $WILDFLY_POSTGRES_MODULE_PATH/module.xml

# Installation of Eclipselink
ADD $ECLIPSELINK_JAR_URL $WILDFLY_ECLIPSELINK_MODULE_PATH/
COPY module-eclipselink.xml $WILDFLY_ECLIPSELINK_MODULE_PATH/module.xml

# Apply directory changes to enable volume binding
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN mkdir -p $WILDFLY_DATA_PATH/files && \
        chown -R jboss:jboss $WILDFLY_HOME_PATH && \
        mkdir -p $TMP_WILDFLY_STANDALONE_FOLDER && \
        cp -R $WILDFLY_CONFIGURATION_PATH $TMP_WILDFLY_STANDALONE_FOLDER/ && \
        cp -R $WILDFLY_DEPLOYMENTS_PATH $TMP_WILDFLY_STANDALONE_FOLDER/ && \
        chmod +x /usr/local/bin/docker-entrypoint.sh

CMD ["/usr/local/bin/docker-entrypoint.sh"]

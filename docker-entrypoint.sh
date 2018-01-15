#!/usr/bin/env bash

cp -r /tmp/wildfly/standalone/deployments /opt/jboss/wildfly/standalone/
cp -r /tmp/wildfly/standalone/configuration /opt/jboss/wildfly/standalone/

/opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0

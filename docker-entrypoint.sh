#!/usr/bin/env bash

cp /tmp/app-0.7.ear /opt/jboss/wildfly/standalone/deployments/app-0.7.ear

/opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0

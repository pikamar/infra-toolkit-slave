#!/bin/bash

if [ "$NO_AUTH" == "true" ] ; then
  java -jar /bin/swarm-client.jar -master "${SWARM_MASTER}" -name "${SLAVE_NAME}" -labels "${SLAVE_LABELS}" -mode "${SLAVE_MODE}"
else
  java -jar /bin/swarm-client.jar -master "${SWARM_MASTER}" -username "${SWARM_USER}" -password "${SWARM_PASSWORD}" -name "${SLAVE_NAME}" -labels "${SLAVE_LABELS}" -mode "${SLAVE_MODE}"
fi
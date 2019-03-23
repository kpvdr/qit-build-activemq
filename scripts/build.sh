#! /bin/bash

. ./scripts/common.sh

cd ${GIT_DIR}
mvn -DskipTests package

# Remove previous extracted instance
rm -rf apache-activemq*

# Extract new instance
TAR_FILE=`ls assembly/target/apache-activemq*.tar.gz`
tar -xzf ${TAR_FILE}

# Add option to allow non-SASL connections to config file - required for test to succeed
TAR_DIR_BASE=`basename ${TAR_FILE}`
TAR_DIR=${TAR_DIR_BASE%-bin.tar.gz}
#ln -s ${TAR_DIR} broker
CONF_FILE="${TAR_DIR}/conf/activemq.xml"
D2N_CONF_FILE="${TAR_DIR}/conf/activemq.d2n.xml"
ENV_FILE=${TAR_DIR}/bin/env
cp ${CONF_FILE} ${D2N_CONF_FILE}
sed -i -f ../activemq.sed ${CONF_FILE}
sed -i -f ../activemq.d2n.sed ${D2N_CONF_FILE}
sed -i -f ../activemq.env.sed ${ENV_FILE}

# Remove old log files
rm -rf broker/data/activemq.*.log

cd ..
ln -s ${GIT_DIR}/${TAR_DIR} broker

#! /bin/bash

if [[ -z ${JENKINS_HOME+x} ]]; then
    JENKINS_HOME="/var/lib/jenkins"
fi
echo "JENKINS_HOME=${JENKINS_HOME}"

function get_dir_name {
    local base=${1##*/}
    GIT_DIR=${base%.*}
}

JOB_NAME="build-activemq"
GIT_REPO="https://github.com/apache/activemq.git"
get_dir_name ${GIT_REPO}

JOB_DIR="${JENKINS_HOME}/workspace/${JOB_NAME}"
PATH="/usr/local/maven/bin:${PATH}"

FROM avsdeveng/java:1.8.65
MAINTAINER "Andre" <andris.jersovs@accenture.com>

ARG TERRAFORM_VERSION="0.7.7"
ARG PACKER_VERSION="0.11.0"
ARG SWARM_CLIENT_VERSION="2.2"

ENV SWARM_MASTER="http://10.0.0.197:8010/jenkins/"
ENV SWARM_USER="john.smith"
ENV SWARM_PASSWORD="Password01"
ENV SLAVE_NAME="Swarm_Slave"
ENV SLAVE_LABELS="swarm"
ENV SLAVE_MODE="normal"
ENV JENKINS_HOME=/var/jenkins_home
ENV PATH=${JENKINS_HOME}:${PATH}
ENV NO_AUTH="false"

RUN yum -y install epel-release && \
    yum -y install unzip PyYAML python-jinja2 python-httplib2 python-keyczar python-paramiko python-setuptools git wget python-pip && \
    pip install ansible && \
    curl -s -o /bin/swarm-client.jar -k https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/${SWARM_CLIENT_VERSION}/swarm-client-${SWARM_CLIENT_VERSION}-jar-with-dependencies.jar && \
    curl -s -o /tmp/terraform.zip -k https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    curl -s -o /tmp/packer.zip -k https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip && \
    unzip /tmp/terraform.zip -d /usr/bin && \
    unzip /tmp/packer.zip -d /usr/bin && \
    yum clean all && \
    rm -rf /var/cache/* && \
    rm -rf /tmp/* && \
    rm -rf /var/log/*

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]


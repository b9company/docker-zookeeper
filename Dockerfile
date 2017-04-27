FROM openjdk:8-jre

LABEL maintainer="the B9 Company <lab@b9company.fr>"

ARG ZOOKEEPER_VERSION
ARG ZOOKEEPER_MIRROR="http://apache.crihan.fr/dist/zookeeper"
ARG ZOOKEEPER_ARCHIVE="${ZOOKEEPER_MIRROR}/zookeeper-${ZOOKEEPER_VERSION}/zookeeper-${ZOOKEEPER_VERSION}.tar.gz"
ARG ZOOKEEPER_DATADIR="/var/lib/zookeeper"
ARG ZOOKEEPER_DATALOGDIR="/var/log/zookeeper"

ENV ZOOKEEPER_HOME "/usr/local/zookeeper"

RUN ["/bin/bash", "-c", "set -o pipefail && wget -qO - \"${ZOOKEEPER_ARCHIVE}\" | tar zx -C /usr/local/"]
RUN ln -s `basename "${ZOOKEEPER_ARCHIVE}" .tar.gz` "${ZOOKEEPER_HOME}" && \
    sed "/^dataDir=/c dataDir=${ZOOKEEPER_DATADIR}\ndataLogDir=${ZOOKEEPER_DATALOGDIR}" "${ZOOKEEPER_HOME}/conf/zoo_sample.cfg" > "${ZOOKEEPER_HOME}/conf/zoo.cfg"

ENV PATH "$PATH:${ZOOKEEPER_HOME}/bin"

WORKDIR "${ZOOKEEPER_HOME}"

VOLUME ["${ZOOKEEPER_DATADIR}", "${ZOOKEEPER_DATALOGDIR}"]

EXPOSE 2181 2888 3888

CMD ["sh", "-c", "bin/zkServer.sh start-foreground"]

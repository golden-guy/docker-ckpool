# syntax=docker/dockerfile:1
FROM debian:11-slim

ARG REPO=ckpool-solo
ARG BRANCH=solobtc
ARG REPO_URL=https://github.com/golden-guy/${REPO}/archive/refs/heads/${BRANCH}.zip

ENV BUILD_DIR=/var/build
ENV BIN_DIR=/srv/ckpool

ENV USER_UID=1000
ENV USER_GID=1000
ENV USER_NAME=ckpool

# create ckpool group and user
RUN groupadd --gid ${USER_GID} ${USER_NAME} \
    && useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USER_NAME}

# install required packages
RUN apt-get update && apt-get install -y autoconf automake libtool build-essential yasm libzmq3-dev libcap2-bin curl unzip

# fetch sources from github
RUN curl -o /tmp/${REPO}.zip -L ${REPO_URL} \
    && unzip -q /tmp/${REPO}.zip -d ${BUILD_DIR}/ \
    && rm -f /tmp/${REPO}.zip

# build ckpool-solo sources
WORKDIR ${BUILD_DIR}/${REPO}-${BRANCH}
RUN ./autogen.sh && ./configure --prefix=${BIN_DIR}
RUN make

# install binaries
RUN make install

# setup conf and logs directories
RUN mkdir -p ${BIN_DIR}/conf
COPY conf/ckpool.conf ${BIN_DIR}/conf
RUN mkdir -p ${BIN_DIR}/logs
RUN chown -R ${USER_NAME}:${USER_NAME} ${BIN_DIR}

# final configuration
EXPOSE 3333
WORKDIR ${BIN_DIR}

# switch to ckpool user
USER ${USER_NAME}

# start ckpool
CMD rm -f /tmp/ckpool/main.pid \
    && ./bin/ckpool -B -c ./conf/ckpool.conf

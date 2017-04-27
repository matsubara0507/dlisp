FROM ubuntu:16.04

MAINTAINER Stefan Rohe <think@hotmail.de>

ENV \
  COMPILER=dmd \
  COMPILER_VERSION=2.062

RUN apt-get update && apt-get install -y curl unzip \
 && curl -fsL -o /dmd2.zip http://downloads.dlang.org/releases/2.x/${COMPILER_VERSION}/${COMPILER}.${COMPILER_VERSION}.zip \
 && unzip /dmd2.zip \
 && rm /dmd2.zip \
 && mv /dmd2 /dlang \
 && apt-get auto-remove -y curl build-essential \
 && apt-get install -y gcc libstdc++5

ENV \
  PATH=/dlang/linux/bin64:${PATH} \
  LD_LIBRARY_PATH=/dlang/linux/lib64 \
  LIBRARY_PATH=/dlang/linux/lib64 \
  PS1="(${COMPILER}-${COMPILER_VERSION}) \\u@\\h:\\w\$"

RUN cd /tmp \
 && echo 'void main() {import std.stdio; stdout.writeln("it works"); }' > test.d \
 && dmd test.d \
 && ./test && rm test*

WORKDIR /src

ENV GOSU_VERSION 1.9
RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates wget \
 && wget -O /usr/local/bin/gosu \
        "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-$(dpkg --print-architecture)" \
 && wget -O /usr/local/bin/gosu.asc \
        "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-$(dpkg --print-architecture).asc" \
 && export GNUPGHOME="$(mktemp -d)" \
 && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
 && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
 && rm -r "${GNUPGHOME}" /usr/local/bin/gosu.asc \
 && chmod +x /usr/local/bin/gosu \
 && gosu nobody true \
 && apt-get auto-remove -y wget \
 && rm -rf /var/lib/apt/lists/* \
 && chmod 755 -R /dlang

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

# ENTRYPOINT ["/entrypoint.sh"]
CMD ["${COMPILER}"]

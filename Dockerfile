FROM scratch

LABEL maintainer="yones.lebady AT gmail.com" \
      keyax.os="ubuntu core" \
      keyax.os.ver="18.04 bionic" \
      keyax.vendor="Keyax"

# https://cloud-images.ubuntu.com (128MB)
# wget https://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-root.tar.xz

# wget https://partner-images.canonical.com/core/bionic/current/ubuntu-bionic-core-cloudimg-amd64-root.tar.gz  (30MB)
ADD ubuntu-bionic-core-cloudimg-amd64-root.tar.gz /
# wget https://partner-images.canonical.com/core/xenial/current/ubuntu-xenial-core-cloudimg-amd64-root.tar.gz  (46MB)
## ADD ubuntu-xenial-core-cloudimg-amd64-root.tar.gz /

# a few minor docker-specific tweaks
# see https://github.com/docker/docker/blob/9a9fc01af8fb5d98b8eec0740716226fadb3735c/contrib/mkimage/debootstrap
RUN set -xe \
# https://github.com/docker/docker/blob/9a9fc01af8fb5d98b8eec0740716226fadb3735c/contrib/mkimage/debootstrap#L40-L48
	&& echo '#!/bin/sh' > /usr/sbin/policy-rc.d \
	&& echo 'exit 101' >> /usr/sbin/policy-rc.d \
	&& chmod +x /usr/sbin/policy-rc.d \
# https://github.com/docker/docker/blob/9a9fc01af8fb5d98b8eec0740716226fadb3735c/contrib/mkimage/debootstrap#L54-L56
	&& dpkg-divert --local --rename --add /sbin/initctl \
	&& cp -a /usr/sbin/policy-rc.d /sbin/initctl \
	&& sed -i 's/^exit.*/exit 0/' /sbin/initctl \
# https://github.com/docker/docker/blob/9a9fc01af8fb5d98b8eec0740716226fadb3735c/contrib/mkimage/debootstrap#L71-L78
	&& echo 'force-unsafe-io' > /etc/dpkg/dpkg.cfg.d/docker-apt-speedup \
# https://github.com/docker/docker/blob/9a9fc01af8fb5d98b8eec0740716226fadb3735c/contrib/mkimage/debootstrap#L85-L105
	&& echo 'DPkg::Post-Invoke { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };' > /etc/apt/apt.conf.d/docker-clean \
	&& echo 'APT::Update::Post-Invoke { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };' >> /etc/apt/apt.conf.d/docker-clean \
	&& echo 'Dir::Cache::pkgcache ""; Dir::Cache::srcpkgcache "";' >> /etc/apt/apt.conf.d/docker-clean \
# https://github.com/docker/docker/blob/9a9fc01af8fb5d98b8eec0740716226fadb3735c/contrib/mkimage/debootstrap#L109-L115
	&& echo 'Acquire::Languages "none";' > /etc/apt/apt.conf.d/docker-no-languages \
# https://github.com/docker/docker/blob/9a9fc01af8fb5d98b8eec0740716226fadb3735c/contrib/mkimage/debootstrap#L118-L130
	&& echo 'Acquire::GzipIndexes "true"; Acquire::CompressionTypes::Order:: "gz";' > /etc/apt/apt.conf.d/docker-gzip-indexes \
# https://github.com/docker/docker/blob/9a9fc01af8fb5d98b8eec0740716226fadb3735c/contrib/mkimage/debootstrap#L134-L151
	&& echo 'Apt::AutoRemove::SuggestsImportant "false";' > /etc/apt/apt.conf.d/docker-autoremove-suggests

# enable the universe
RUN sed -i 's/^#\s*\(deb.*universe\)$/\1/g' /etc/apt/sources.list

# make systemd-detect-virt return "docker"
# See: https://github.com/systemd/systemd/blob/aa0c34279ee40bce2f9681b496922dedbadfca19/src/basic/virt.c#L434
RUN mkdir -p /run/systemd && echo 'docker' > /run/systemd/container

RUN apt-get update && apt-get install --assume-yes --no-install-recommends \
# for building Couchbase Nodejs driver from source : manke gcc ...
#    build-essential \
# download binaries for Nodejs
		curl \
# download binaries for gosu, MongoDB, Couchbase
		wget \
# openssl
  	ca-certificates \
    openssh-server \
    gnupg2 \
# certificates manager x.509  CRL OCSP GnuPG
		dirmngr \
		nano \
    python \
# shell json parser
    jq \
#   nfs-common \
#   nfs-kernel-server \
# tar.xz compression libraries for Nodejs install
		xz-utils \
# to disable numa for MongoDB
    numactl \
		&& apt-get autoremove && apt-get clean \
# delete all the apt list files since they're big and get stale quickly
  	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# this forces "apt-get update" in dependent images, which is also good

# sudo apt-get remove gnupg
# sudo ln -s /usr/bin/gpg2 /usr/bin/gpg

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
#RUN groupadd -r -g 10000 kyxgrp && useradd -r -g kyxgrp 10000 kyxusr
RUN  groupadd --gid 11000 kyxgrp \
  && useradd  --uid 11000 --gid kyxgrp --password kyxpwd kyxusr \
  && chown -R kyxusr:kyxgrp /home/kyxusr
# && useradd  --uid 11000 --gid kyxgrp --shell /bin/bash --home-dir /home/kyxusr --password kyxpwd kyxusr
RUN echo root:rootpwd | chpasswd
USER kyxusr
WORKDIR /home/kyxusr

# overwrite this with 'CMD []' in a dependent Dockerfile
CMD ["/bin/bash"]

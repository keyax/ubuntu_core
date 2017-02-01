# ubuntu-core image for docker minimal os
[![](https://images.microbadger.com/badges/image/keyax/ubuntu_core.svg)](https://microbadger.com/images/keyax/ubuntu_core "Get your own image badge on microbadger.com")   [![](https://images.microbadger.com/badges/version/keyax/ubuntu_core.svg)](https://microbadger.com/images/keyax/ubuntu_core "Get your own version badge on microbadger.com")

Supported tags and respective Dockerfile links
16.10, yakkety-20170104, yakkety (yakkety/Dockerfile)

For more information about this image and its history, please see the relevant manifest file (library/ubuntu).

For detailed information about the virtual/transfer sizes and individual layers of each of the above supported tags, please see the repos/ubuntu/tag-details.md file in the docker-library/repo-info GitHub repo.

What is Ubuntu?
Ubuntu is a Debian-based Linux operating system, with Unity as its default desktop environment. It is based on free software and named after the Southern African philosophy of ubuntu (literally, "human-ness"), which often is translated as "humanity towards others" or "the belief in a universal bond of sharing that connects all humanity".

Development of Ubuntu is led by UK-based Canonical Ltd., a company owned by South African entrepreneur Mark Shuttleworth. Canonical generates revenue through the sale of technical support and other services related to Ubuntu. The Ubuntu project is publicly committed to the principles of open-source software development; people are encouraged to use free software, study how it works, improve upon it, and distribute it.

wikipedia.org/wiki/Ubuntu_(operating_system)



What's in this image?
This image is built from official rootfs tarballs provided by Canonical (specifically, https://partner-images.canonical.com/core/).

The ubuntu:latest tag points to the "latest LTS", since that's the version recommended for general use.

Along a similar vein, the ubuntu:devel tag is an alias for whichever release the "devel" suite on the mirrors currently points to, as determined by the following one-liner: wget -qO- http://archive.ubuntu.com/ubuntu/dists/devel/Release | awk -F ': ' '$1 == "Codename" { print $2; exit }'

/etc/apt/sources.list
ubuntu:16.04
$ docker run ubuntu:16.04 grep -v '^#' /etc/apt/sources.list

deb http://archive.ubuntu.com/ubuntu/ xenial main restricted
deb-src http://archive.ubuntu.com/ubuntu/ xenial main restricted

deb http://archive.ubuntu.com/ubuntu/ xenial-updates main restricted
deb-src http://archive.ubuntu.com/ubuntu/ xenial-updates main restricted

deb http://archive.ubuntu.com/ubuntu/ xenial universe
deb-src http://archive.ubuntu.com/ubuntu/ xenial universe
deb http://archive.ubuntu.com/ubuntu/ xenial-updates universe
deb-src http://archive.ubuntu.com/ubuntu/ xenial-updates universe


deb http://archive.ubuntu.com/ubuntu/ xenial-security main restricted
deb-src http://archive.ubuntu.com/ubuntu/ xenial-security main restricted
deb http://archive.ubuntu.com/ubuntu/ xenial-security universe
deb-src http://archive.ubuntu.com/ubuntu/ xenial-security universe
ubuntu:14.04
$ docker run ubuntu:14.04 grep -v '^#' /etc/apt/sources.list

deb http://archive.ubuntu.com/ubuntu/ trusty main restricted
deb-src http://archive.ubuntu.com/ubuntu/ trusty main restricted

deb http://archive.ubuntu.com/ubuntu/ trusty-updates main restricted
deb-src http://archive.ubuntu.com/ubuntu/ trusty-updates main restricted

deb http://archive.ubuntu.com/ubuntu/ trusty universe
deb-src http://archive.ubuntu.com/ubuntu/ trusty universe
deb http://archive.ubuntu.com/ubuntu/ trusty-updates universe
deb-src http://archive.ubuntu.com/ubuntu/ trusty-updates universe


deb http://archive.ubuntu.com/ubuntu/ trusty-security main restricted
deb-src http://archive.ubuntu.com/ubuntu/ trusty-security main restricted
deb http://archive.ubuntu.com/ubuntu/ trusty-security universe
deb-src http://archive.ubuntu.com/ubuntu/ trusty-security universe

Supported Docker versions
This image is officially supported on Docker version 1.13.0.

Support for older versions (down to 1.6) is provided on a best-effort basis.

Please see the Docker installation documentation for details on how to upgrade your Docker daemon.

User Feedback
Issues
If you have any problems with or questions about this image, please contact us through a GitHub issue. If the issue is related to a CVE, please check for a cve-tracker issue on the official-images repository first.

You can also reach many of the official image maintainers via the #docker-library IRC channel on Freenode.

Contributing
You are invited to contribute new features, fixes, or updates, large or small; we are always thrilled to receive pull requests, and do our best to process them as fast as we can.

Before you start to code, we recommend discussing your plans through a GitHub issue, especially for more ambitious contributions. This gives other contributors a chance to point you in the right direction, give you feedback on your design, and help you find out if someone else is working on the same thing.

Documentation
Documentation for this image is stored in the ubuntu/ directory of the docker-library/docs GitHub repo. Be sure to familiarize yourself with the repository's README.md file before attempting a pull request.

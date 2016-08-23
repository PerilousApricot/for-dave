FROM evansde77/py_ci_image
MAINTAINER 1337 Melo <andrew.melo@gmail.com>

ADD https://get.docker.com/builds/Linux/x86_64/docker-1.7.1 /usr/bin/docker
RUN chmod +x /usr/bin/docker
ENTRYPOINT ["/sbin/my_init"]

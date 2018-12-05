FROM debian:jessie

ENV DEBIAN_FRONTEND="noninteractive"

VOLUME ["/var/cache/apt"]

ARG APT_INSTALL_ARGS="-fy --no-install-recommends"

ARG DEPENDENCIES="\
	gcc \
	gcc-mingw-w64 \
	git \
	libtevent-dev \
	samba-dev \
	"

RUN apt-get update --fix-missing

RUN apt-get install \
        ${APT_INSTALL_ARGS} \
        ${DEPENDENCIES}

ARG APP_DIR="/opt/winexe"

ADD ./winexe ${APP_DIR}

RUN cd ${APP_DIR}/source \
	&& ./waf configure build \
	&& ln -fsv ${PWD}/build/winexe /usr/bin/

ENTRYPOINT ["winexe"]

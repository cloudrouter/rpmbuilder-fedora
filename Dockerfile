FROM fedora:24
MAINTAINER "John Siegrist" <john.siegrist@complects.com>
ENV REFRESHED_AT=2016-10-10

ENV TARGET=/target
ENV RPM_BUILD_DIR=/rpmbuild
ENV SOURCES=/sources
ENV WORKSPACE=/workspace

# copy dependencies file
COPY ./assets/dependencies /var/run/docker-build-deps

RUN dnf -y updateinfo \
    && dnf install -y $(cat /var/run/docker-build-deps) \
    && dnf install -y --allowerasing systemd-libs \
    && dnf -y upgrade \
    && dnf clean all

WORKDIR ${WORKSPACE}

RUN mkdir -p \
    ${TARGET} \
    ${RPM_BUILD_DIR} \
    ${SOURCES} \
    ${WORKSPACE}

RUN ln -sf ${RPM_BUILD_DIR} /root/rpmbuild \
    && rpmdev-setuptree

ADD ./assets/buildrpm /usr/bin/buildrpm
RUN chmod +x /usr/bin/buildrpm

VOLUME [ "${TARGET}", "${RPM_BUILD_DIR}", "${SOURCES}", "${WORKSPACE}" ]

CMD ["/usr/bin/buildrpm"]

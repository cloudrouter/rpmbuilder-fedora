# VERSION 0.3
FROM fedora:23
MAINTAINER "John Siegrist" <john.siegrist@complects.com>
ENV REFRESHED_AT 2016-03-30

RUN dnf -y updateinfo \
    && dnf install -y \
      https://repo.cloudrouter.org/3/fedora/23/x86_64/cloudrouter-fedora-repo-latest.noarch.rpm \
      curl \
      dnf-plugins-core \
      rpm-build \
      rpmdevtools \
      vim \
      wget \
    && dnf -y upgrade \
    && dnf clean all

ENV TARGET /target
ENV RPM_BUILD_DIR /rpmbuild
ENV SOURCES /sources
ENV WORKSPACE /workspace

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

CMD ["buildrpm"]

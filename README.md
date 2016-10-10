# rpmbuilder-fedora
Docker Image for building CloudRouter Fedora-based RPMs

#### Non-interactive build

```sh
SOURCES=`pwd`/sources
TARGET=`pwd`/target
mkdir -p ${TARGET}
docker run --rm \
  -v ${SOURCES}:/sources:Z \
  -v ${TARGET}:/target:Z \
  cloudrouter/rpmbuilder-fedora
```

`${SOURCES}` is where the RPM source project and/or spec file is located.

You should see your build output in the `${TARGET}` directory.

#### Interactive builds
```sh
TARGET=`pwd`/target
mkdir -p ${TARGET}
docker run --rm -it --entrypoint /usr/bin/bash \
  -v ${SOURCES}:/sources:Z \
  -v ${TARGET}:/target:Z \
  cloudrouter/rpmbuilder-fedora
```
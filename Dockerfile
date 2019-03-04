FROM fedora:29
MAINTAINER Ben Boeckel <ben.boeckel@kitware.com>

# Install build dependencies for packages.
RUN dnf install -y \
        git-core \
        openssl-devel make \
        re2c \
        subversion gcc-c++ mpfr-devel libmpc-devel isl-devel flex bison file findutils && \
    dnf clean all

RUN useradd -c modules -d /home/modules -M modules && \
    mkdir /home/modules && \
    chown modules:modules /home/modules

USER modules

COPY install_cmake.sh /home/modules/install_cmake.sh
RUN sh /home/modules/install_cmake.sh

COPY install_ninja.sh /home/modules/install_ninja.sh
RUN sh /home/modules/install_ninja.sh

COPY install_gcc.sh /home/modules/install_gcc.sh
COPY trtbd.diff /home/modules/trtbd.diff
RUN sh /home/modules/install_gcc.sh

RUN git clone https://gitlab.kitware.com/ben.boeckel/cxx-modules-sandbox.git /home/modules/code/cxx-modules-sandbox/src
WORKDIR /home/modules
COPY build-env.sh /home/modules/build-env.sh
ENTRYPOINT ["/home/modules/build-env.sh", "/bin/sh"]

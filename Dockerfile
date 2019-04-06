FROM fedora:29
MAINTAINER Ben Boeckel <ben.boeckel@kitware.com>

# Install build dependencies for packages.
COPY install_deps.sh /root/install_deps.sh
RUN sh /root/install_deps.sh

RUN useradd -c modules -d /home/modules -M modules && \
    mkdir /home/modules && \
    chown modules:modules /home/modules

USER modules

COPY install_gcc.sh /home/modules/install_gcc.sh
COPY trtbd.diff /home/modules/trtbd.diff
RUN sh /home/modules/install_gcc.sh

COPY install_clang.sh /home/modules/install_clang.sh
RUN sh /home/modules/install_clang.sh

COPY install_cmake.sh /home/modules/install_cmake.sh
RUN sh /home/modules/install_cmake.sh

COPY install_ninja.sh /home/modules/install_ninja.sh
RUN sh /home/modules/install_ninja.sh

RUN git clone https://gitlab.kitware.com/ben.boeckel/cxx-modules-sandbox.git /home/modules/code/cxx-modules-sandbox/src
WORKDIR /home/modules
COPY README /home/modules/README
COPY build-env.sh /home/modules/build-env.sh
ENTRYPOINT ["/home/modules/build-env.sh", "/bin/sh"]

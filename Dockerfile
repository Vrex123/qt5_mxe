FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    autoconf \
    automake \
    autopoint \
    bash \
    bison \
    bzip2 \
    flex \
    g++ \
    g++-multilib \
    gettext \
    git \
    gperf \
    intltool \
    libc6-dev-i386 \
    libgdk-pixbuf2.0-dev \
    libltdl-dev \
    libssl-dev \
    libtool-bin \
    libxml-parser-perl \
    lzip \
    make \
    openssl \
    p7zip-full \
    patch \
    perl \
    pkg-config \
    python \
    ruby \
    sed \
    unzip \
    wget \
    xz-utils \
    git

# see http://stackoverflow.com/questions/10934683/how-do-i-..

# Preapre and download cross development environment
RUN mkdir /build
WORKDIR /build
RUN git clone https://github.com/mxe/mxe.git

RUN cd mxe &&\
    make -j4 \
    cc \
    qtbase \
    qtwebsockets \
    qtserialport \
    qtactiveqt \
    qtbase_CONFIGURE_OPTS=-debug-and-release \
    qtwebsockets_CONFIGURE_OPTS=-debug-and-release \
    qtserialport_CONFIGURE_OPTS=-debug-and-release \
    qtactiveqt_CONFIGURE_OPTS=-debug-and-release \
    MXE_PLUGIN_DIRS=plugins/gcc7 \
    MXE_TARGETS=i686-w64-mingw32.static

# Enhance path
ENV PATH /build/mxe/usr/bin:$PATH

# Add a qmake alias
RUN ln -s /build/mxe/usr/bin/i686-w64-mingw32.static-qmake-qt5 /build/mxe/usr/bin/qmake



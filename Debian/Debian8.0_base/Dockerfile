FROM debian:8.0
ENV DEBIAN_FRONTEND noninteractive
COPY Base_Congifure-install.sh /
COPY GCC_CMake-install.sh /
RUN apt-get update
RUN apt-get install -y dialog apt-transport-https ca-certificates apt-utils vim wget curl \
    git nano libtool libtool-bin libglib2.0-0 glib2.0 libpixman-1-dev htop autoconf \
    automake build-essential apt-transport-https cmake sudo software-properties-common \
    gperf libselinux1-dev  bison texinfo flex zlib1g-dev libexpat1-dev libmpg123-dev python3-pip \
    python-pip unzip pkg-config apt-utils gcc g++ net-tools lsb-core debian-keyring debian-archive-keyring \
    libssl1.0.0 libncurses5-dev libncursesw5-dev libreadline6-dev libssl-doc  \
    ncurses-doc libssl-dev libgdbm-dev libsqlite3-dev bison libbz2-dev libexpat1 \
    liblzma-dev zlib1g-dev openssl ssh gawk zip unzip
#安装zlibg
RUN bash Base_Congifure-install.sh
RUN bash GCC_CMake-install.sh
EXPOSE 22

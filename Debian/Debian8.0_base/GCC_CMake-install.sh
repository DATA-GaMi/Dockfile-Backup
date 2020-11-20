#!/usr/bin/env bash

#Debian基础运行路径
export BASE_PATH=$PWD
#Python安装路径
export INSTALL_PATH=/usr/share/

cd "$INSTALL_PATH" || return ;
#安装依赖GMP
wget -c https://gcc.gnu.org/pub/gcc/infrastructure/gmp-6.1.0.tar.bz2
bzip2 -dfv gmp-6.1.0.tar.bz2 && tar -xvf gmp-6.1.0.tar && rm gmp-6.1.0.tar && cd gmp-6.1.0 || return
#编译&安装
./configure && make && make install

cd "$INSTALL_PATH" || return ;
#安装依赖MPF
wget -c https://gcc.gnu.org/pub/gcc/infrastructure/mpfr-3.1.4.tar.bz2
bzip2 -dfv mpfr-3.1.4.tar.bz2 && tar -xvf mpfr-3.1.4.tar && rm mpfr-3.1.4.tar && cd mpfr-3.1.4 || return
#编译&安装
./configure && make && make install

cd "$INSTALL_PATH" || return ;
#安装依赖MPC
wget -c https://gcc.gnu.org/pub/gcc/infrastructure/mpc-1.0.3.tar.gz
tar -zxvf mpc-1.0.3.tar.gz && rm mpc-1.0.3.tar.gz && cd mpc-1.0.3 || return
#编译&安装
./configure && make && make install

cd "$INSTALL_PATH" || return ;
#安装gcc-6.5.0
wget http://mirrors.ibiblio.org/gnu/ftp/gnu/gcc/gcc-6.5.0/gcc-6.5.0.tar.gz
tar -zxvf gcc-6.5.0.tar.gz && rm gcc-6.5.0.tar.gz && cd gcc-6.5.0 || return
#编译&安装
./configure --disable-multilib && make && make install

cd "$INSTALL_PATH" || return ;
#下载二进制版的cmake-3.18.5
wget -c https://github.com/Kitware/CMake/releases/download/v3.18.5/cmake-3.18.5-Linux-x86_64.tar.gz
tar -zxvf cmake-3.18.5-Linux-x86_64.tar.gz && rm cmake-3.18.5-Linux-x86_64.tar.gz && mv cmake-3.18.5-Linux-x86_64 cmake-3.18
#cmake的二进制elf文件在/usr/share/cmake-3.18/bin目录下
rm /usr/bin/cmake
#跨文件系统-链接
ln -sf /usr/share/cmake-3.18/bin/cmake /usr/bin/cmake
ln -sf /usr/share/cmake-3.18/bin/ccmake /usr/bin/ccmake
ln -sf /usr/share/cmake-3.18/bin/cpack /usr/bin/cpack
ln -sf /usr/share/cmake-3.18/bin/ctest /usr/bin/ctest


cd "$BASE_PATH" || return

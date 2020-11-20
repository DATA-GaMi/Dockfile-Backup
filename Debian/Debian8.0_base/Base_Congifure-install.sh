#!/usr/bin/env bash
set -m
#Debian基础运行路径
export BASE_PATH=$PWD
#Python安装路径
export INSTALL_PATH=/usr/share/
apt-get install gcc-6* g++-6*
#安装zlibg
cd "$INSTALL_PATH" || return ;
echo "Install zlibg" ;
wget https://jaist.dl.sourceforge.net/project/libpng/zlib/1.2.11/zlib-1.2.11.tar.gz ;
tar -zxvf zlib-1.2.11.tar.gz && rm zlib-1.2.11.tar.gz ;
cd zlib-1.2.11/ || return ;
./configure > /dev/null;make && make install ;
cd "$BASE_PATH" || return

#安装openssl-1.1.1g
cd "$INSTALL_PATH" || return ;
echo "Install openssl" ;
wget https://www.openssl.org/source/openssl-1.1.1g.tar.gz ;
tar -zxvf openssl-1.1.1g.tar.gz && rm openssl-1.1.1g.tar.gz && cd openssl-1.1.1g && ./config --prefix=/usr/local/openssl no-zlib;make && make install ;
mv /usr/bin/openssl /usr/bin/openssl.bak && mv /usr/include/openssl/ /usr/include/openssl.bak ;
ln -s /usr/local/openssl/include/openssl /usr/include/openssl ;
ln -s /usr/local/openssl/lib/libssl.so.1.1 /usr/local/lib64/libssl.so ;
ln -s /usr/local/openssl/bin/openssl /usr/bin/openssl ;
echo "/usr/local/openssl/lib" >> /etc/ld.so.conf ;
ldconfig -v > /dev/null ;
openssl version ;
export LDFLAGS=" -L/usr/local/openssl/lib" ;
export CPPFLAGS=" -I/usr/local/openssl/include" ;
export PKG_CONFIG_PATH="/usr/local/openssl/lib/pkgconfig" ;
cd "$BASE_PATH" || return

#安装Python3.6.12
cd "$INSTALL_PATH" || return ;
echo -e "Downloading Python3.6.12..." ;
wget --no-check-certificate https://www.python.org/ftp/python/3.6.12/Python-3.6.12.tgz ;
tar -zxvf Python-3.6.12.tgz;rm Python-3.6.12.tgz;mv Python-3.6.12 python3.6 ;
cd python3.6/ && ./configure --with-ssl && make && make install ;
python3 -m pip install --upgrade pip ;
cd "$BASE_PATH" || return

#设置优先级
echo "Set Python update-alernatives" ;
update-alternatives --install /usr/local/bin/python3 python3 /usr/local/bin/python3.6 200 ;
python3 -m pip install --upgrade pip ;
pip3 -V

#pip库
pip3 install networkx
pip3 install pydot
pip3 install pydotplus



#安装clang与llvm
apt-get install -y llvm-4.0-* clang-4.0-* ;
update-alternatives --install /usr/bin/clang clang /usr/bin/clang-4.0 200 ;
update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-4.0 200 ;
update-alternatives --install /usr/bin/llvm-config llvm-config /usr/bin/llvm-config-4.0 200 ;
hash -r


#安装aflfast
git clone https://github.com/mboehme/aflfast.git
export LLVM=/aflfast/llvm_mode
export QEMU=/aflfast/qemu_mode
cd /aflfast || return
make clean && make
cd "$LLVM" ||return
make clean && make
cd "$QEMU" ||return
bash build_qemu_support.sh
cd /aflfast || return
make install
cd /aflfast/libdislocator || return
make
cd /aflfast/libtokencap || return
make
cd /
echo -e "\033[36mAll Done!\033[0m"
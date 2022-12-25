#!/bin/bash

set -e
set -x

./autogen.sh
./configure --prefix="${PREFIX}" --with-x --enable-xspice --enable-cider --with-readline=yes --enable-openmp --enable-pss --disable-debug
make V=1 -j$CPU_COUNT
make V=1 install

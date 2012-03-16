#!/bin/bash

source $ZMQ_ANDROID_CONFIG

include_dir=$INSTALL_PATH/include
lib_dir=$INSTALL_PATH/lib
tools_prefix=$TOOLCHAIN_TOP/bin/arm-linux-androideabi

LD_LIBRARY_PATH=$lib_dir  \
	CFLAGS="-fPIC -I$include_dir -I$TOOLCHAIN_TOP/arm-none-linux-gnueabi/include -Wl,-rpath=$TOOLCHAIN_TOP/arm-none-linux-gnueabi/lib" \
	CPPFLAGS="-I$include_dir" \
	LDFLAGS="-L$lib_dir -Wl,-rpath=$lib_dir" \
	CC=$tools_prefix-gcc \
	CXX=$tools_prefix-g++ \
	LD=$tools_prefix-ld \
	AR=$tools_prefix-ar \
	AS=$tools_prefix-as \
	RANLIB=$tools_prefix-ranlib \
	./configure --target=arm-linux-gnueabi --host=arm-linux-android --prefix=$INSTALL_PATH

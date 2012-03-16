#!/bin/bash

source $ZMQ_ANDROID_CONFIG

tools_prefix=$TOOLCHAIN_TOP/bin/arm-linux-androideabi

CC=$tools_prefix-gcc \
	LD=$tools_prefix-ld \
	AR=$tools_prefix-ar \
	AS=$tools_prefix-as \
	RANLIB=$tools_prefix-ranlib \
	./configure --target=arm-linux-androideabi --host=arm-linux-androideabi --prefix=$INSTALL_PATH --enable-elf-shlibs

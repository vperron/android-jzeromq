#!/bin/bash


source $ZMQ_ANDROID_CONFIG

include_dir=$INSTALL_PATH/include
lib_dir=$INSTALL_PATH/lib
tools_prefix=$TOOLCHAIN_TOP/bin/arm-linux-androideabi


### generate zmq.jar using JDK 1.6 ###
##############################################


LD_LIBRARY_PATH=$lib_dir:$LD_LIBRARY_PATH

make clean && \
	find . -name "*.class" -o -name "jzmq-headers.zip" -o -name "zmq.jar" -delete

# Just to make sure...
rm $INSTALL_PATH/lib/libzmq.la

PATH=$JDK6_PATH/bin:$PATH \
	CFLAGS="-fPIC -I$include_dir -I$TOOLCHAIN_TOP/arm-linux-androideabi/include -Wl,-rpath=$TOOLCHAIN_TOP/arm-linux-androideabi/lib" \
	CPPFLAGS="-I$include_dir" \
	LDFLAGS="-L$lib_dir -Wl,-rpath=$lib_dir" \
	CC=$tools_prefix-gcc \
	CXX=$tools_prefix-g++ \
	LD=$tools_prefix-ld \
	AR=$tools_prefix-ar \
	AS=$tools_prefix-as \
	RANLIB=$tools_prefix-ranlib \
	./configure --target=arm-linux-gnueabi --host=arm-linux-gnueabi --prefix=$INSTALL_PATH --with-zeromq=$INSTALL_PATH



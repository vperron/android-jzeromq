#!/bin/bash

include_dir=$INSTALL_PATH/include
lib_dir=$INSTALL_PATH/lib
tools_prefix=$ARM_TOOLCHAIN/bin/arm-linux-androideabi

if [ ! -f .is_configured ]; then \
	LD_LIBRARY_PATH=$lib_dir \
	CFLAGS="-fPIC -I$include_dir -I$ARM_TOOLCHAIN/arm-none-linux-gnueabi/include -Wl,-rpath=$ARM_TOOLCHAIN/arm-none-linux-gnueabi/lib" \
	CPPFLAGS="-I$include_dir -fvisibility=default -I$ARM_TOOLCHAIN/arm-linux-androideabi/include/c++/4.6 -I$ARM_TOOLCHAIN/arm-linux-androideabi/include/c++/4.6/arm-linux-androideabi" \
	LDFLAGS="-L$lib_dir -lgcc -Wl,-rpath=$lib_dir -Wl,-Bstatic -luuid -Wl,-Bdynamic" \
	CC=$tools_prefix-gcc \
	CXX=$tools_prefix-g++ \
	LD=$tools_prefix-ld \
	AR=$tools_prefix-ar \
	AS=$tools_prefix-as \
	RANLIB=$tools_prefix-ranlib \
	./configure --target=arm-linux-gnueabi --host=arm-linux-android --with-uuid=$INSTALL_PATH --enable-static --disable-shared --prefix=$INSTALL_PATH && \
	touch .is_configured; fi

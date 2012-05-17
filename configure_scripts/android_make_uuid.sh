#!/bin/bash

tools_prefix=$ARM_TOOLCHAIN/bin/arm-linux-androideabi

if [ ! -f .is_configured ]; then \
	CC=$tools_prefix-gcc \
	LD=$tools_prefix-ld \
	AR=$tools_prefix-ar \
	AS=$tools_prefix-as \
	RANLIB=$tools_prefix-ranlib \
	./configure --target=arm-linux-androideabi --host=arm-linux-androideabi --prefix=$INSTALL_PATH && \
	touch .is_configured; fi

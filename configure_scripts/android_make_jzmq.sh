#!/bin/bash


include_dir=$INSTALL_PATH/include
lib_dir=$INSTALL_PATH/lib
tools_prefix=$ARM_TOOLCHAIN/bin/arm-linux-androideabi

LD_LIBRARY_PATH=$lib_dir:$LD_LIBRARY_PATH


# Avoid version numbering
sed -i -e 's/^libjzmq_la_LDFLAGS = .*$/libjzmq_la_LDFLAGS = -avoid-version/' src/Makefile.am

rm -f $INSTALL_PATH/lib/libzmq.la

if [ ! -f .is_configured ]; then \
	./autogen.sh && \
	PATH=$JAVA_HOME/bin:$PATH \
	CFLAGS="-fPIC -I$include_dir -I$ARM_TOOLCHAIN/arm-linux-androideabi/include -Wl,-rpath=$ARM_TOOLCHAIN/arm-linux-androideabi/lib" \
	CPPFLAGS="-I$include_dir" \
	LDFLAGS="-L$lib_dir -Wl,-rpath=$lib_dir" \
	LIBS="-luuid" \
	CC=$tools_prefix-gcc \
	CXX=$tools_prefix-g++ \
	LD=$tools_prefix-ld \
	AR=$tools_prefix-ar \
	AS=$tools_prefix-as \
	RANLIB=$tools_prefix-ranlib \
	./configure --target=arm-linux-gnueabi --host=arm-linux-gnueabi --prefix=$INSTALL_PATH --with-zeromq=$INSTALL_PATH && \
	touch src/classdist_noinst.stamp && \
	cd src && CLASSPATH=.:./.:$CLASSPATH javac -d . org/zeromq/ZMQ.java \
		org/zeromq/ZMQException.java org/zeromq/ZMQQueue.java org/zeromq/ZMQForwarder.java \
		org/zeromq/ZMQStreamer.java org/zeromq/ZContext.java org/zeromq/ZFrame.java org/zeromq/ZMsg.java && \
		cd .. && \
	touch .is_configured; fi



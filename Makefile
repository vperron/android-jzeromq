
-include ${ZMQ_ANDROID_CONFIG}

TARGET := $(INSTALL_PATH)/libjzmq.so
LIBZMQ := $(INSTALL_PATH)/lib/libzmq.a
LIBUUID := $(INSTALL_PATH)/lib/libuuid.a

TOP_DIR := $(shell pwd)

.PHONY: all clean

define make_component
	cp $(TOP_DIR)/configure_scripts/$1 $2 && \
		cd $(TOP_DIR)/$2 && \
		./$1 && \
		cd $3 && \
		$(MAKE) && \
		sudo $(MAKE) install
endef

all: $(TARGET)

$(TARGET): $(LIBZMQ)
	$(call make_component,android_make_jzmq.sh,jzmq,.)

$(LIBZMQ): $(LIBUUID)
	$(call make_component,android_make_zmq.sh,zeromq-2.2.0,.)

$(LIBUUID):
	$(call make_component,android_make_uuid.sh,e2fsprogs,lib/uuid)

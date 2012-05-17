
-include ${ZMQ_ANDROID_CONFIG}

TARGET := $(INSTALL_PATH)/libjzmq.so
LIBZMQ := $(INSTALL_PATH)/lib/libzmq.a
LIBUUID := $(INSTALL_PATH)/lib/libuuid.a

ZMQ_DIR := zeromq-2.2.0
JZMQ_DIR := zeromq-jzmq-8522576
UUID_DIR := e2fsprogs-1.42.3

zmq_url := http://download.zeromq.org/zeromq-2.2.0.tar.gz
jzmq_url := https://github.com/zeromq/jzmq/tarball/v1.0.0
uuid_url := http://downloads.sourceforge.net/project/e2fsprogs/e2fsprogs/v1.42.3/e2fsprogs-1.42.3.tar.gz

TOP_DIR := $(shell pwd)

.PHONY: all clean prereq

define make_component
	cp $(TOP_DIR)/configure_scripts/$1 $2 && \
		cd $(TOP_DIR)/$2 && \
		./$1 && \
		cd $3 && \
		$(MAKE) && \
		sudo $(MAKE) install
endef

all: $(TARGET)

prereq: $(ZMQ_DIR) $(JZMQ_DIR) $(UUID_DIR)


# TODO: Replace those rules with implicits

$(ZMQ_DIR): $(notdir $(zmq_url))
	tar xzf $<

$(JZMQ_DIR): $(notdir $(jzmq_url))
	tar xzf $<

$(UUID_DIR): $(notdir $(uuid_url))
	tar xzf $<

$(notdir $(zmq_url)):
	wget $(zmq_url)

$(notdir $(jzmq_url)):
	wget $(jzmq_url)

$(notdir $(uuid_url)):
	wget $(uuid_url)

$(TARGET): $(LIBZMQ)
	$(call make_component,android_make_jzmq.sh,$(JZMQ_DIR),.)

$(LIBZMQ): $(LIBUUID)
	cp $(TOP_DIR)/configure_scripts/zmq_android.patch $(ZMQ_DIR)
	$(call make_component,android_make_zmq.sh,$(ZMQ_DIR),.)

$(LIBUUID): prereq
	$(call make_component,android_make_uuid.sh,$(UUID_DIR),lib/uuid)

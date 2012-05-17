TOP_DIR := $(shell pwd)

TARGET := $(INSTALL_PATH)/libjzmq.so
LIBZMQ := $(INSTALL_PATH)/lib/libzmq.a
LIBUUID := $(INSTALL_PATH)/lib/libuuid.a

zmq_dir := zeromq-2.2.0
jzmq_dir := zeromq-jzmq-8522576
uuid_dir := e2fsprogs-1.42.3

zmq_url := http://download.zeromq.org/zeromq-2.2.0.tar.gz
jzmq_url := https://github.com/zeromq/jzmq/tarball/v1.0.0
uuid_url := http://downloads.sourceforge.net/project/e2fsprogs/e2fsprogs/v1.42.3/e2fsprogs-1.42.3.tar.gz


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

prereq: $(zmq_dir) $(jzmq_dir) $(uuid_dir)


# TODO: Replace those rules with implicits
$(zmq_dir): $(notdir $(zmq_url))
	tar xzf $<

$(jzmq_dir): $(notdir $(jzmq_url))
	tar xzf $<

$(uuid_dir): $(notdir $(uuid_url))
	tar xzf $<

$(notdir $(zmq_url)):
	wget $(zmq_url)

$(notdir $(jzmq_url)):
	wget $(jzmq_url)

$(notdir $(uuid_url)):
	wget $(uuid_url)

$(TARGET): $(LIBZMQ)
	$(call make_component,android_make_jzmq.sh,$(jzmq_dir),.)

$(LIBZMQ): $(LIBUUID)
	$(call make_component,android_make_zmq.sh,$(zmq_dir),.)

$(LIBUUID): prereq
	$(call make_component,android_make_uuid.sh,$(uuid_dir),lib/uuid)

clean:
	rm -rf $(jzmq_dir)
	rm -rf $(zmq_dir)
	rm -rf $(uuid_dir)

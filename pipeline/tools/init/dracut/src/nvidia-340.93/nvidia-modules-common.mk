#
# This Makefile was automatically generated; do not edit.
# Generated on 'swio-display-x86-rhel47-03' on Wed Aug 19 16:00:07 PDT 2015.
#

#
# KBUILD common Makefile fragment for NVIDIA Linux kernel modules.
#
# This file contains common Makefile rules and definitions which are shared
# between the build systems for various Linux kernel modules included as part
# of the NVIDIA Linux driver.
#
# kbuild Makefile originally developed by:
#
# Alistair J Strachan (alistair@devzero.co.uk) (first pass, enhancements)
# Christian Zander (zander@mail.minion.de) (enhancements
#

.PHONY: all install suser-sanity-check rmmod-sanity-check build-sanity-checks \
module module-sign module-install package-install clean print-module-filename \
conftest-compile-test

all: install
install: package-install

#
# The precompiled kernel module build process requires a separation of the
# closed source and open source object files.
#

KERNEL_GLUE_NAME := nv-linux$(NV_MODULE_SUFFIX).o
KERNEL_GLUE_OBJS := $(MODULE_GLUE_OBJS) $(MODULE_NAME).mod.o

obj-m := $(MODULE_NAME).o
#
# Include local source directory in $(CC)'s include path and set disable any
# warning types that are of little interest to us.
#

EXTRA_CFLAGS += -I$(src)
EXTRA_CFLAGS += -Wall -MD $(DEFINES) $(INCLUDES) -Wsign-compare -Wno-cast-qual -Wno-error

#
# Output directory for the build; default to the source directory if not set.
# The source directory should be set by the including Makefile, but set it
# to a reasonable default here, just in case.
#

src ?= .
obj ?= $(src)

#
# Determine location of the Linux kernel source tree. Allow users to override
# the default (i.e. automatically determined) kernel source location with the
# SYSSRC directive; this new directive replaces NVIDIA's SYSINCLUDE.
#

ifdef SYSSRC
 KERNEL_SOURCES := $(SYSSRC)
 KERNEL_HEADERS := $(KERNEL_SOURCES)/include
else
 KERNEL_UNAME ?= $(shell uname -r)
 KERNEL_MODLIB := /lib/modules/$(KERNEL_UNAME)
 KERNEL_SOURCES := $(shell test -d $(KERNEL_MODLIB)/source && echo $(KERNEL_MODLIB)/source || echo $(KERNEL_MODLIB)/build)
 KERNEL_HEADERS := $(KERNEL_SOURCES)/include
endif

KERNEL_OUTPUT := $(KERNEL_SOURCES)
KBUILD_PARAMS :=

ifdef SYSOUT
 ifneq ($(SYSOUT), $(KERNEL_SOURCES))
 KERNEL_OUTPUT := $(SYSOUT)
 KBUILD_PARAMS := KBUILD_OUTPUT=$(KERNEL_OUTPUT)
 endif
else
 KERNEL_UNAME ?= $(shell uname -r)
 KERNEL_MODLIB := /lib/modules/$(KERNEL_UNAME)
 ifeq ($(KERNEL_SOURCES), $(KERNEL_MODLIB)/source)
 KERNEL_OUTPUT := $(KERNEL_MODLIB)/build
 KBUILD_PARAMS := KBUILD_OUTPUT=$(KERNEL_OUTPUT)
 endif
endif

CC ?= cc
HOST_CC ?= $(CC)
LD ?= ld

ifndef ARCH
 ARCH := $(shell uname -m | sed -e 's/i.86/i386/' \
 -e 's/armv[0-7]\w\+/arm/' \
 -e 's/aarch64/arm64/' \
 -e 's/ppc64le/powerpc/' \
 )
endif

CONFTEST := /bin/sh $(src)/conftest.sh "$(CC)" "$(HOST_CC)" $(ARCH) $(KERNEL_SOURCES) $(KERNEL_OUTPUT)

KERNEL_UNAME ?= $(shell $(CONFTEST) get_uname)
MODULE_ROOT := /lib/modules/$(KERNEL_UNAME)/kernel/drivers

#
# Sets any internal variables left unset by KBUILD (e.g. this happens during
# a top-level run).
#

TOPDIR ?= $(KERNEL_SOURCES)

#
# Linux 2.6 uses the .ko module extension.
#

MODULE_OBJECT := $(MODULE_NAME).ko

#
# NVIDIA specific CFLAGS and #define's.
#

EXTRA_CFLAGS += -D__KERNEL__ -DMODULE -DNVRM -DNV_VERSION_STRING=\"340.93\" -Wno-unused-function -Wuninitialized -fno-strict-aliasing -mno-red-zone -mcmodel=kernel -DNV_UVM_ENABLE -D__linux__ -DNV_DEV_NAME=\"$(MODULE_NAME)\"

#
# Detect SGI UV systems and apply system-specific optimizations.
#
ifneq ($(wildcard /proc/sgi_uv),)
 EXTRA_CFLAGS += -DNV_CONFIG_X86_UV
endif

#
# Command for signing kernel modules
#

MOD_SIGN_CMD ?= $(KERNEL_SOURCES)/scripts/sign-file

#
# Miscellaneous NVIDIA kernel module build support targets. They are needed
# to satisfy KBUILD requirements and to support NVIDIA specifics.
#

$(obj)/$(CORE_OBJS):
	@cp $(src)/$(CORE_OBJS) $(obj)/$(CORE_OBJS)

$(obj)/$(VERSION_HEADER):
	@echo \#define NV_COMPILER \"`$(CC) -v 2>&1 | tail -n 1`\" > $@

CONFTEST_COMPILE_TEST_HEADERS := $(obj)/conftest/macros.h \
$(obj)/conftest/functions.h $(obj)/conftest/symbols.h $(obj)/conftest/types.h \
$(obj)/conftest/generic.h

CONFTEST_HEADERS := $(obj)/conftest.h $(CONFTEST_COMPILE_TEST_HEADERS) \
$(obj)/conftest/patches.h

$(obj)/conftest.h $(CONFTEST_COMPILE_TEST_HEADERS): conftest-compile-test

conftest-compile-test: $(src)/conftest.sh
	@if ! $(CONFTEST) compile_tests $(COMPILE_TESTS); then exit 1; fi

$(obj)/conftest/patches.h:
	@if ! $(CONFTEST) patch_check; then exit 1; fi

MODULE_GLUE_TARGETS = $(addprefix $(obj)/,$(MODULE_GLUE_OBJS))

$(MODULE_GLUE_TARGETS): $(CONFTEST_HEADERS)

$(obj)/nv.o: $(obj)/$(VERSION_HEADER)

#
# KBUILD build parameters.
#

ifndef NV_VERBOSE
 ifneq ($(strip $(QUIET)),1)
 NV_VERBOSE=1
 else
 NV_VERBOSE=0
 endif
endif

KBUILD_PARAMS += KBUILD_VERBOSE=$(NV_VERBOSE)
KBUILD_PARAMS += -C $(KERNEL_SOURCES) SUBDIRS=$(PWD)
KBUILD_PARAMS += ARCH=$(ARCH)

#
# NVIDIA sanity checks.
#

suser-sanity-check:
	@if ! $(CONFTEST) suser_sanity_check; then exit 1; fi

rmmod-sanity-check:
	@if ! $(CONFTEST) rmmod_sanity_check; then exit 1; fi

BUILD_SANITY_CHECKS = \
	cc_version_check \
	rivafb_sanity_check \
	nvidiafb_sanity_check \
	dom0_sanity_check \
	xen_sanity_check \
	preempt_rt_sanity_check

build-sanity-checks:
	@for SANITY_CHECK in $(BUILD_SANITY_CHECKS); do \
	 if ! $(CONFTEST) $$SANITY_CHECK full_output; then \
	 exit 1; \
	 fi; \
	done

#
# BUILD_MODULE_RULE generates rules for building individual module targets.
#
# $(1) is the name of the module to build e.g. nvidia.ko, nvidia[0-7].ko,
# nvidia-frontend.ko, or nvidia-uvm.ko
# $(2) is the input to NV_MODULE_SUFFIX corresponding to a particular 
# module name.
# $(3) any additional prerequisites
#
# The caller is responsible for ensuring that any desired modules are
# added as dependencies of the "module" target, which builds the NVIDIA
# kernel module(s) using Linux KBUILD, and is used by the "package-install"
# target below.
#

define BUILD_MODULE_RULE
 $(1): build-sanity-checks $(3)
	@echo "NVIDIA: calling KBUILD..."; \
	$$(MAKE) "CC=$$(CC)" NV_MODULE_SUFFIX=$$(strip $(2)) $$(KBUILD_PARAMS) modules; \
	echo "NVIDIA: left KBUILD."; \
	if ! [ -f $(1) ]; then \
	 echo "$(1) failed to build!"; \
	 exit 1; \
	elif [ -f split-object-file.sh ]; then \
	 /bin/sh split-object-file.sh $(1); \
	fi
endef


#
# Sign the NVIDIA kernel module with the provided key. In the multiple NVIDIA
# kernel module case only the specified module is built and signed.
#

module-sign: $(MODULE_OBJECT)
	@if [ -z "$(MODSECKEY)" ] || [ -z "$(MODPUBKEY)" ]; then \
	 echo "ERROR: MODSECKEY and MODPUBKEY must be set to sign modules!"; \
	 exit 1; \
	elif ! [ -f "$(MODSECKEY)" ]; then \
	 echo "ERROR: cant find MODSECKEY \"$(MODSECKEY)\""; \
	 exit 1; \
	elif ! [ -f "$(MODPUBKEY)" ]; then \
	 echo "ERROR: can't find MODPUBKEY \"$(MODPUBKEY)\""; \
	 exit 1; \
	elif ! [ -x "$(MOD_SIGN_CMD)" ]; then \
	 echo "ERROR: \"$(MOD_SIGN_CMD)\" not executable!"; \
	 exit 1; \
	fi
	HASH=$(CONFIG_MODULE_SIG_HASH); \
 if [ -z "$$HASH" ]; then \
	 HASH=$$($(CONFTEST) guess_module_signing_hash | sed s/\"//g); \
	fi; \
	if [ $$? -eq 0 ] && [ -n $$HASH ]; then \
	 "$(MOD_SIGN_CMD)" $$HASH "$(MODSECKEY)" "$(MODPUBKEY)" \
 "$(MODULE_OBJECT)"; \
	 if [ $$? -eq 0 ]; then \
	 exit 0; \
	 fi; \
	fi; \
	"$(MOD_SIGN_CMD)" "$(MODSECKEY)" "$(MODPUBKEY)" $(MODULE_OBJECT)

#
# Build the NVIDIA kernel module with KBUILD. Verify that the user posesses
# sufficient privileges. Rebuild the module dependency file.
#

module-install: suser-sanity-check module
	@mkdir -p $(MODULE_ROOT)/video; \
	install -m 0664 -o root -g root $(MODULE_OBJECT) $(MODULE_ROOT)/video; \
	PATH="$(PATH):/bin:/sbin" depmod -a

#
# This target builds, then installs, then creates device nodes and inserts
# the module, if successful.
#

package-install: module-install rmmod-sanity-check
	@PATH="$(PATH):/bin:/sbin" modprobe $(MODULE_NAME) && \
	echo "$(MODULE_OBJECT) installed successfully.";

#
# Check if the linker script module-common.lds exists. If it does, pass that
# as a linker option (via variable MODULE_COMMON_SCRIPT) while building the 
# kernel interface file. This script does some processing on the module symbols
# on which the Linux kernel's module resolution is dependent and hence must be 
# used whenever present.
#

LD_SCRIPT ?= $(KERNEL_SOURCES)/scripts/module-common.lds
MODULE_COMMON_SCRIPT := $(if $(wildcard $(LD_SCRIPT)),-T $(LD_SCRIPT))

#
# Build an object file suitable for further processing by the installer
# and inclusion as a precompiled kernel interface file. Note the
# dependency on 'module', and not just the input object files. This is
# because we rely on KBUILD to produce the latter as part of the
# full kernel module build. In the multiple NVIDIA kernel module case, 
# only the required target corresponding to the specified precompiled 
# kernel interface is built.
#

$(KERNEL_GLUE_NAME): $(MODULE_OBJECT)
	@$(LD) $(EXTRA_LDFLAGS) $(MODULE_COMMON_SCRIPT) -r -o $(KERNEL_GLUE_NAME) $(KERNEL_GLUE_OBJS)

#
# Support hack, KBUILD isn't prepared to clean up after external modules.
#

clean:
	@$(RM) -f $(MODULE_GLUE_OBJS) $(KERNEL_GLUE_OBJS)
	@$(RM) -f build-in.o nv-linux*.o *.d .*.cmd .*.flags
	@$(RM) -f $(MODULE_NAME)*.o $(MODULE_NAME)*.ko*
	@$(RM) -f $(MODULE_NAME)*.mod* $(VERSION_HEADER) *~
	@$(RM) -f conftest*.c conftest.h
	@$(RM) -rf conftest
	@$(RM) -rf Module*.symvers .tmp_versions modules.order

#
# This target just prints the kernel module filename (for use by the
# installer).
#

print-module-filename:
	@echo $(MODULE_OBJECT)

####################################################################
#
#		Maya Version & Location
#
####################################################################




MAYA_VERSION:=$(shell /bin/python2 -c 'import pipe;print pipe.apps.maya().version()')
MAYA_LOCATION=$(shell /bin/python2 -c 'import pipe;pipe.apps.maya();pipe.apps.version.set(maya="$(MAYA_VERSION)");print pipe.apps.maya().path()')
# MAYA_LOCATION=$(shell /bin/python2 -c 'import pipe;print pipe.apps.maya().path()')
CORTEX=$(shell /bin/python2 -c 'import pipe;print pipe.libs.cortex().path()')
EXR=$(shell /bin/python2 -c 'import pipe;print pipe.libs.openexr().path()')
ILMBASE=$(shell /bin/python2 -c 'import pipe;print pipe.libs.ilmbase().path()')
BOOST_VERSION=$(shell /bin/python2 -c 'import pipe;print pipe.libs.boost().version()')
EXR_VERSION=$(shell /bin/python2 -c 'import pipe;print pipe.libs.openexr().version()')
LIBS_PATH=$(shell /bin/python2 -c 'import pipe;print pipe.roots.libs()')
SHAVE_ROOT=$(shell /bin/python2 -c 'import pipe;print pipe.apps.shave().path()')

GCC_PATH=$(LIBS_PATH)/gcc/4.1.2/bin/


ifeq ($(MAYA_VERSION),)
	result=$(shell for n in $(/bin/python2 -c "import pipe;v=pipe.apps.maya().versionList();v.sort;print ' '.join(v[:2])") ; do echo $$n;\
		make MAYA_LOCATION=$(/bin/python2 -c 'import pipe;pipe.apps.maya();pipe.apps.version.set(maya="2014");print pipe.apps.maya().path()') MAYA_VERSION=$$n ;\
	done )
	return
endif


$(info BOOST = $(BOOST_VERSION))
$(info $(MAYA_LOCATION))
$(info $(CORTEX))
$(info $(GCC_PATH))

ifndef MAYA_LOCATION
$(error "MAYA_LOCATION is not defined")
endif

ifeq ($(wildcard $(MAYA_LOCATION)),)
$(error "MAYA_LOCATION contains '$(MAYA_LOCATION)', which does not exist.")
endif

#
# Get the Maya version number.  (Actually, just the API version, but that's
# all we care about.)
#
# temp := $(shell grep '^[ \t]*\#define[ \t]*MAYA_API_VERSION' $(MAYA_LOCATION)/include/maya/MTypes.h | sed 's/^[^0-9]*//')
#
# mayaMajorVersion := $(shell echo $(temp) | sed 's/\(.*\)[0-9][0-9]$$/\1/')
# mayaMinorVersion := $(shell echo $(temp) | sed 's/.*\([0-9]\)[0-9]$$/\1/')
# mayaSubVersion := $(shell echo $(temp) | sed 's/.*\([0-9]\)$$/\1/')
#
# ifeq ($(mayaSubVersion),0)
#     mayaVersion := $(mayaMajorVersion).$(mayaMinorVersion)
# else
#     mayaVersion := $(mayaMajorVersion).$(mayaMinorVersion).$(mayaSubVersion)
# endif
#
# ifeq ($(findstring -x64,$(MAYA_LOCATION)),-x64)
# else
#     bits := 32
# endif
# bits := 64
# mayaVersion := $(mayaVersion)-x64
#
# arch := $(shell uname -i)


####################################################################
#
#		Compiler & Linker
#
####################################################################

#
# Some versions of Maya use non-standard versions of gcc are used, which are
# expected to be installed in /opt (e.g. /opt/gcc322)
#
CFLAGS		= -g -pipe -D_BOOL -DLINUX -Wall -Wall -Wno-deprecated -fno-gnu-keywords -fPIC
CC		= $(GCC_PATH)/gcc
C++		= $(GCC_PATH)/g++
#
# ifeq ($(bits),64)
#     # CPU = -march=athlon64
# else
#     CPU = -march=i686
# endif
#
# ifeq ($(mayaMajorVersion),7)
#    CC	= /opt/gcc334/bin/gcc334
#    C++	= /opt/gcc334/bin/c++334
#    CFLAGS += -DREQUIRE_IOSTREAM
# else
#   ifeq ($(mayaMajorVersion),6)
#     ifeq ($(mayaMinorVersion),0)
#       CC	= /opt/gcc332/bin/gcc332
#       C++	= /opt/gcc332/bin/c++332
#       CPU	= -mcpu=pentiumpro
#     endif
#     CFLAGS	+= -DREQUIRE_IOSTREAM
#   else
#     ifeq ($(mayaMajorVersion),5)
#       CC	= /opt/gcc322/bin/gcc322
#       C++	= /opt/gcc322/bin/c++322
#       CFLAGS	+= -DREQUIRE_IOSTREAM
#       CPU	= -mcpu=pentiumpro
#     endif
#   endif
# endif
#
# CFLAGS		+= $(CPU)
#
# # On x86_64 we need to specify how many bits we're compiling for.
# ifeq ($(arch),x86_64)
#     CFLAGS += -m$(bits)
# endif

PLUGIN_INCLUDES = -I$(SHAVE_ROOT)/maya$(MAYA_VERSION)/include -I$(SHAVE_ROOT)/maya$(MAYA_VERSION)/modules/JoeAlter/shaveHaircut/samples -I$(MAYA_LOCATION)/include -I. -I$(CORTEX)/include -L$(CORTEX)/maya/$(MAYA_VERSION)/include/ -I$(EXR)/include -I$(ILMBASE)/include -I$(ILMBASE)/include/OpenEXR
PLUGIN_LIBS     = -L$(SHAVE_ROOT)/maya$(MAYA_VERSION)/lib -L$(SHAVE_ROOT)/maya$(MAYA_VERSION)/modules/JoeAlter/shaveHaircut/samples -L$(MAYA_LOCATION)/lib -L$(CORTEX)/lib/boost$(BOOST_VERSION)/ -L$(CORTEX)/maya/$(MAYA_VERSION)/lib/ -L$(EXR)/lib -L$(ILMBASE)/lib -L. -lShaveAPI -lOpenMaya -lIECore -lIECoreMaya -lImath

APP_INCLUDES    = -I. -I$(SHAVE_ROOT)/maya$(MAYA_VERSION)/include -I$(SHAVE_ROOT)/maya$(MAYA_VERSION)/modules/JoeAlter/shaveHaircut/samples
APP_LIBS        = -L$(SHAVE_ROOT)/maya$(MAYA_VERSION)/lib/ -L$(SHAVE_ROOT)/maya$(MAYA_VERSION)/modules/JoeAlter/shaveHaircut/samples/ -lShaveEngine-x64 -lpthread


SCENE=$(shell pwd)/shave.ma

$(info $(SCENE))

####################################################################
#
#		Build Rules
#
####################################################################

all:	shaveCortexWriter_$(MAYA_VERSION).so shaveAPITestApp

shaveCortexWriter_$(MAYA_VERSION).so:	shaveCortexWriter.cpp
	$(C++) $(CFLAGS) -o $@ -shared $(PLUGIN_INCLUDES) $(PLUGIN_LIBS) shaveCortexWriter.cpp

shaveAPITestApp:	shaveAPITestApp.cpp
	$(C++) $(CFLAGS) -o $@ $(APP_INCLUDES) $(APP_LIBS) shaveAPITestApp.cpp

shave_test.cob: all
	@ /bin/python2 -c "print '='*200"
	export PWD=$$(pwd) ; run mayapy -c "import pymel.core, time, IECore, IECoreRI;import maya.cmds as m;from maya.mel import eval as meval;m.file('$(SCENE)',o=1,f=1);m.loadPlugin('$$PWD/shaveCortexWriter_$(MAYA_VERSION).so');t=time.time();nodes=m.ls(type='shaveHair');m.currentTime(1,e=1);meval('shaveCortexWriter -e \\\"$$PWD/shave_test.0001.cob\\\" \\\"%s\\\"' % ','.join(nodes));m.currentTime(2,e=1);meval('shaveCortexWriter -q \\\"$$PWD/shave_test.0002.cob\\\" \\\"%s\\\"' % ','.join(nodes));m.currentTime(3,e=1);meval('shaveCortexWriter -q \\\"$$PWD/shave_test.0003.cob\\\" \\\"%s\\\"' % ','.join(nodes));print 'export time:', time.time()-t;IECore.Reader.create('$$PWD/shave_test.0001.cob').read().render( IECoreRI.Renderer('$$PWD/shave_test.rib') )"
	@ /bin/python2 -c "print '='*200"

clean:
	rm -rf *.so shaveAPITestApp *.cob *.rib

install: all
	mkdir -p ../maya/$(MAYA_VERSION)/
	cp shaveAPITestApp ../maya/$(MAYA_VERSION)/
	cp shaveCortexWriter_$(MAYA_VERSION).so ../maya/$(MAYA_VERSION)/shaveCortexWriter.so

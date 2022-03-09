

CD:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
SHELL:=/bin/bash
DOCKER?=0
PKG?=
PARALLEL?=
RAMDISK?=
_CORES_:=$(shell grep MHz /proc/cpuinfo  | wc -l)
CORES?=${_CORES_}
LLVM_CORES?=$(shell [ ${_CORES_} -gt 8 ] && echo 8 || expr ${_CORES_} / 2 )
OPENVDB_CORES?=$(shell expr  ${_CORES_} / 2  )
PRE_CMD?=
POS_CMD?=
CUSTOM_LIB_FOLDER?=
STUDIO?=$(shell echo $STUDIO)
DEBUG?=


all: help

help:
	@echo ""
	@echo "make build   - build packages"
	@echo "make shell   - run a shell inside the build container"
	@echo "make image   - make booth cache and build images and upload then."
	@echo "               You should run this one when adding new packages, "
	@echo "               so the build image is also done!"
	@echo "make upload  - make the build docker image and upload"
	@echo "make cache   - make the package cache docker image and upload it."
	@echo "make matrix  - display the github action matrix."
	@echo "make help    - display this help screen."
	@echo ""
	@echo "optionals:"
	@echo "     make build DOCKER=0        - disable re-building the docker images. ex: make build DOCKER=0"
	@echo "     make build PKG=<pkg name>  - build just a specific package, instead of everything."
	@echo "     make build PARALLEL=#      - Run scons in parallel, with # number of jobs."
	@echo "     make build RAMDISK=1       - Use ramdisk to build packages."
	@echo "     make build LLVM_CORES=4    - set the number of parallel jobs when building LLVM."
	@echo "                                  on machines with high core number, LLVM can use too"
	@echo "                                  much memory to build. So we have to reduce the # of jobs."
	@echo "     make build CUSTOM_LIB_FOLDER=<custom folder to put libs>"
	@echo "     make image PRE_CMD=<cmd>   - Run a command line before downloading pkgs. Use this to delete"
	@echo "                                  pre-downloaded caches for re-download and cleanup."
	@echo "                                  ex: make image PRE_CMD=\"rm -rf /atomo/pipeline/build/.downloads/pip*\""
	@echo ""


ifneq "${CORES}" ""
BUILD_EXTRA:=${BUILD_EXTRA} CORES=${CORES} DCORES=$(shell expr ${CORES} + ${CORES}) HCORES=$(shell expr ${CORES} / 2)
endif
ifneq "${LLVM_CORES}" ""
BUILD_EXTRA:=${BUILD_EXTRA} LLVM_CORES=${LLVM_CORES}
endif
ifneq "${OPENVDB_CORES}" ""
BUILD_EXTRA:=${BUILD_EXTRA} OPENVDB_CORES=${OPENVDB_CORES}
endif
ifneq "${PARALLEL}" ""
BUILD_EXTRA:=${BUILD_EXTRA} -j ${PARALLEL}
endif
ifneq "${DEBUG}" ""
BUILD_EXTRA:=${BUILD_EXTRA} -d
endif
ifneq "${PKG}" ""
BUILD_EXTRA:=${BUILD_EXTRA} ${PKG}
else
BUILD_EXTRA:=${BUILD_EXTRA} all
endif

ifneq "${BUILD_EXTRA}" ""
BUILD_EXTRA:= -e ' ${BUILD_EXTRA} install '
endif

ifneq "${CUSTOM_LIB_FOLDER}" ""
_CUSTOM_LIB_FOLDER:=$(shell readlink -f ${CUSTOM_LIB_FOLDER})
endif

ifeq "${STUDIO}" ""
STUDIO="atomo"
export STUDIO
endif
$(info ${STUDIO})

build: upload
	export CUSTOM_LIB_FOLDER=${_CUSTOM_LIB_FOLDER} ;\
	${CD}/pipeline/tools/scripts/pipevfx -b ${BUILD_EXTRA}

build_gcc: upload_centos
	@IMAGE=centos ${CD}/pipeline/tools/scripts/pipevfx -b -e 'build-gcc'

shell: upload
	@${CD}/pipeline/tools/scripts/pipevfx -s

matrix: upload
	# @${CD}/pipeline/tools/scripts/pipevfx -b | tee matrix.txt
	@cd pipeline/build/ ; scons install MATRIX=1 2>&1 | tee ${CD}/matrix.txt
	@export phases=$$( cat matrix.txt | grep -v ARGUMENTS | egrep 'github.*=>' | awk -F'phase: ' '{print $$2}' | awk -F' =>' '{print "\""$$1"\","}' ) ;\
	echo "{ \"name\": [ "$$(echo $$phases | sed 's/,$$//')", \"all\" ] }"

upload: #cache
	@[ "${DOCKER}" == "1" ] && DOCKER=1 ${CD}/pipeline/tools/scripts/pipevfx -u || echo "Not building docker image!"

upload_centos:
	@[ "${DOCKER}" == "1" ] && DOCKER=1 IMAGE=centos ${CD}/pipeline/tools/scripts/pipevfx -u || echo "Not building docker image!"

cache:
	@[ "${DOCKER}" == "1" ] && \
	DOCKER=1 \
	PRE_CMD='${PRE_CMD}' \
	POS_CMD='${POS_CMD}' \
	${CD}/pipeline/tools/scripts/pipevfx -p || echo "Not building docker image!"

image: cache upload

hub_delete:
	export USERNAME=myuser \
	export PASSWORD=mypass \
	export ORGANIZATION=myorg (if it's personal, then it's your username) \
	export REPOSITORY=myrepo \
	export TAG=latest \
	curl -u $USERNAME:$PASSWORD -X "DELETE" https://cloud.docker.com/v2/repositories/$ORGANIZATION/$REPOSITORY/tags/$TAG/

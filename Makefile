

CD:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
SHELL:=/bin/bash
DOCKER?=0
PKG?=
EXTRA?=
PARALLEL?=
RAMDISK?=
_CORES_:=$(shell grep MHz /proc/cpuinfo  | wc -l)
CORES?=${_CORES_}
LLVM_CORES?=$(shell [ ${CORES} -gt 8 ] && echo 8 || expr ${CORES} / 2 )
# OPENVDB_CORES?=$(shell expr  [ ${CORES} -gt 8 ] && echo 8 || expr ${CORES} / 2  )
PRE_CMD?=
POS_CMD?=
CUSTOM_LIB_FOLDER?=
STUDIO?=$(shell echo $$STUDIO)
DEBUG?=
HUB_USER?=$(shell echo $$HUB_USER)
HUB_PASS?=$(shell echo $$HUB_PASS)
PIPEVFX_LIBS_VERSION?=$(shell echo $$PIPEVFX_LIBS_VERSION)
EXTRA_MOUNTS?=$(shell echo $$EXTRA_MOUNTS)

all: help

help:
	@echo ""
	@echo "make build   - build packages"
	@echo "make shell   - run a shell inside the build container (use EXTRA_MOUNTS"
	@echo "               env var to add mounts to docker run)"
	@echo "make image   - make booth cache and build images and upload then."
	@echo "               You should run this one when adding new packages, "
	@echo "               so the build image is also done!"
	@echo "make upload  - make the build docker image and upload"
	@echo "make cache   - make the package cache docker image and upload it."
	@echo "make list    - list images with tags from docker hub. "
	@echo "make delete  - delete an image tag from docker hub. "
	@echo "               Set env vars \$HUB_USER as username and \$HUB_PASS as"
	@echo "               password for docker hub."
	@echo "               Set IMAGE=<image name:tag> as the image to delete"
	@echo "               ex: make delete IMAGE=pipevfx_pkgs:centos7_latest"
	@echo "make matrix  - display the github action matrix. (>matrix.txt)"
	@echo "make tree    - display the scons dependency tree. (>tree.txt)"
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

ifneq "${PIPEVFX_LIBS_VERSION}" ""
BUILD_EXTRA:=${BUILD_EXTRA} PIPEVFX_LIBS_VERSION=${PIPEVFX_LIBS_VERSION}
endif
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
ifneq "${EXTRA}" ""
BUILD_EXTRA:=${BUILD_EXTRA} ${EXTRA}
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
STUDIO=pipevfx
endif
export STUDIO
$(info STUDIO=${STUDIO})

build: upload
	export CUSTOM_LIB_FOLDER=${_CUSTOM_LIB_FOLDER} ;\
	${CD}/pipeline/tools/scripts/pipevfx -b ${BUILD_EXTRA}

build_centos: upload_centos
	export CUSTOM_LIB_FOLDER=${_CUSTOM_LIB_FOLDER} ;\
	IMAGE=centos ${CD}/pipeline/tools/scripts/pipevfx -b ${BUILD_EXTRA}

build_gcc: upload_centos
	@IMAGE=centos ${CD}/pipeline/tools/scripts/pipevfx -b -e 'build-gcc'

shell: upload
	export EXTRA_MOUNTS=" -v /${STUDIO}/home:/${STUDIO}/home $$EXTRA_MOUNTS" ; \
		${CD}/pipeline/tools/scripts/pipevfx -s

tree: upload
	cd pipeline/build/ ; scons install all MATRIX=1 --tree=all,prune,status ${PKG} 2>&1 | tee ${CD}/tree.txt

matrix: upload
	# @${CD}/pipeline/tools/scripts/pipevfx -b | tee matrix.txt
	cd pipeline/build/ ; scons install MATRIX=1 ${EXTRA} ${PKG} 2>&1 | tee ${CD}/matrix.txt
	@export phases=$$( cat matrix.txt | grep -v ARGUMENTS | grep -v Error | egrep 'github.*=>' | awk -F'phase: ' '{print $$2}' | awk -F' =>' '{print "\""$$1"\","}' ) ;\
	echo -e "\n\n{ \"name\": [ "$$(echo $$phases | sed 's/,$$//')", \"all\" ] }"

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

list:
	@if [ "$$HUB_USER" == "" ] || [ "$$HUB_PASS" == "" ] ; then \
		echo "Please define HUB_USER and HUB_PASS as env vars or as parameter to make!!" ;\
	else \
		for n in $$(docker search $$HUB_USER | grep pipevfx | awk '{print $$1}') ; do \
			curl -L https://registry.hub.docker.com/v2/repositories/$$n/tags 2>/dev/null  | sed 's/,/\n/g' | egrep '^.name' | awk -F'"' '{print $$(NF-1)}' | while read tag ; \
				do echo $$n:$$tag ; \
			done ; \
		done ;\
	fi

delete:
	@if [ "$$HUB_USER" == "" ] || [ "$$HUB_PASS" == "" ] ; then \
		echo "Please define HUB_USER and HUB_PASS as env vars or as parameter to make!!" ;\
	else \
		echo "Docker hub user: $$HUB_USER" &&\
		export HUB_TOKEN=$$(curl -s -H "Content-Type: application/json" -X POST -d "{\"username\": \"${HUB_USER}\", \"password\": \"${HUB_PASS}\"}" https://hub.docker.com/v2/users/login/ | jq -r .token) &&\
		export IMG2=$$(echo "${IMAGE}" | awk -F'/' '{print $$(NF)}') &&\
		export IMG=$$(echo "$$IMG2" | awk -F':' '{print $$1}') &&\
		export TAG=$$(echo "$$IMG2" | awk -F':' '{print $$2}') &&\
		curl -L https://registry.hub.docker.com/v1/repositories/$$HUB_USER/$$IMG/tags  | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n'  | awk -F: '{print $$3}' &&\
		echo -n "Deleting ${IMAGE}..." &&\
		curl -i -X DELETE -H "Accept: application/json"   -H "Authorization: JWT $$HUB_TOKEN"   https://hub.docker.com/v2/repositories/${HUB_USER}/$$IMG/tags/$$TAG/ &&\
		echo "[DONE]" || echo "[ERROR]" ;\
		curl -L https://registry.hub.docker.com/v1/repositories/$$HUB_USER/$$IMG/tags | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n'  | awk -F: '{print $$3}' ;\
	fi

image: cache upload

hub_delete:
	export USERNAME=myuser \
	export PASSWORD=mypass \
	export ORGANIZATION=myorg (if it's personal, then it's your username) \
	export REPOSITORY=myrepo \
	export TAG=latest \
	curl -u $USERNAME:$PASSWORD -X "DELETE" https://cloud.docker.com/v2/repositories/$ORGANIZATION/$REPOSITORY/tags/$TAG/

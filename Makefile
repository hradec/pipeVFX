

CD:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

all: help

help:
	@echo ""
	@echo "make build	- build packages"
	@echo "make shell	- run a shell inside the build container"
	@echo "make upload	- make the package cache docker image, the build docker image and upload then"
	@echo "make cache	- make the package cache docker image and upload it. Run it when new packages and versions are added."
	@echo ""


build: upload
	@${CD}/pipeline/tools/scripts/pipevfx -b

build_gcc: upload_centos
	@IMAGE=centos ${CD}/pipeline/tools/scripts/pipevfx -b -e 'build-gcc'

shell:
	@${CD}/pipeline/tools/scripts/pipevfx -s

upload: 
	@${CD}/pipeline/tools/scripts/pipevfx -u

upload_centos:
	@IMAGE=centos ${CD}/pipeline/tools/scripts/pipevfx -u

cache:
	@${CD}/pipeline/tools/scripts/pipevfx -p

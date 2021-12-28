

CD:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

all: help

help:
	@echo ""
	@echo "make build	- build packages"
	@echo "make shell	- run a shell inside the build container"
	@echo "make upload	- make the package cache docker image, the build docker image and upload then"
	@echo "make cache	- make the package cache docker image and upload it"
	@echo ""


build:
	@${CD}/pipeline/tools/scripts/pipevfx -b

shell:
	@${CD}/pipeline/tools/scripts/pipevfx -s

upload: cache
	@${CD}/pipeline/tools/scripts/pipevfx -u

cache:
	@${CD}/pipeline/tools/scripts/pipevfx -p

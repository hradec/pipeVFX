#!/bin/bash


CD=$(readlink -f $(dirname $BASH_SOURCE))
cd $CD

grub-mkstandalone \
        -d /usr/lib/grub/x86_64-efi/   \
        -O x86_64-efi  \
        --fonts="unicode"  \
        -o ../grub.efi \
	net \
	efinet \
	tftp \
	gzio \
	part_gpt \
	efi_gop \
	efi_uga \
	fakebios \
        configfile boot/grub/grub.cfg

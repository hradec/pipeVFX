#!/bin/sh

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright 2021 Jookia <contact@jookia.org>

check() {
    return 0
}

depends() {
    echo "systemd-initrd"
    return 0
}

install() {
    inst_hook cmdline 20 "$moddir/parse-overlay.sh"
    inst_hook cleanup 10 "$moddir/overlay-needshutdown.sh"
    inst_script "$moddir/overlay-generator.sh" "$systemdutildir"/system-generators/dracut-overlay-generator
}

installkernel() {
    hostonly='' instmods overlay
}

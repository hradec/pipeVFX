#!/bin/sh

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright 2021 Jookia <contact@jookia.org>

type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh

[ -z "$root" ] && root=$(getarg root=)
[ -z "$overlay" ] && overlay=$(getarg overlay=)
[ -z "$overlay" ] && return 0

rootok=1
root="overlay"
export root rootok

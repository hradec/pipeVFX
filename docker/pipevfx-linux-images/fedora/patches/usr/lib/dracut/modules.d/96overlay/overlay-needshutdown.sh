#!/bin/sh

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright 2021 Jookia <contact@jookia.org>

type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh

if test "${root}" = "overlay"; then
    need_shutdown
fi

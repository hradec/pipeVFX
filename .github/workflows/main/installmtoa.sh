#! /bin/bash
##########################################################################
#
#  Copyright (c) 2019, Cinesite VFX Ltd. All rights reserved.
#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions are
#  met:
#
#      * Redistributions of source code must retain the above
#        copyright notice, this list of conditions and the following
#        disclaimer.
#
#      * Redistributions in binary form must reproduce the above
#        copyright notice, this list of conditions and the following
#        disclaimer in the documentation and/or other materials provided with
#        the distribution.
#
#      * Neither the name of Cinesite VFX Ltd. nor the names of
#        any other contributors to this software may be used to endorse or
#        promote products derived from this software without specific prior
#        written permission.
#
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
#  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
#  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
#  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
#  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
#  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
#  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
#  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
#  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
##########################################################################

set -e

if [ -z $1 ] ; then
	echo "Usage : installmtoa.sh mtoaVersion mayaVersion" >&2
	exit 1
fi

mtoaVersion=$1
mayaVersion=$2

if [[ `uname` = "Linux" ]] ; then
	arnoldPlatform=linux
else
	arnoldPlatform=darwin
fi

url=forgithubci.solidangle.com/mtoa/MtoA-${mtoaVersion}-${arnoldPlatform}-${mayaVersion}.run

# Configure the login information, if this has been supplied.
login=""
if [ ! -z "${ARNOLD_LOGIN}" ] && [ ! -z "${ARNOLD_PASSWORD}" ] ; then
	login="${ARNOLD_LOGIN}:${ARNOLD_PASSWORD}@"
fi

mkdir -p mtoaRoot/$mtoaVersion && cd mtoaRoot/$mtoaVersion

echo Downloading MtoA "https://${url}"
curl -L https://${login}${url} -o mtoa-${mtoaVersion}-${arnoldPlatform}-${mayaVersion}.run

sh ../mtoa-${mtoaVersion}-${arnoldPlatform}-${mayaVersion}.run --tar xvf
mkdir -p install && cd install
unzip ../package.zip

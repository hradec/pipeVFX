#!/bin/bash

server=192.168.0.12

CD=$(dirname $(readlink -f $BASH_SOURCE))
cd $CD/pipeline/tags/

# loop over tags and creates the tag folders pulling the tar file from the github releases
git tag | while read tag ; do
	echo $tag
	echo "https://github.com/hradec/pipeVFX/archive/$tag.tar.gz"
	if [ ! -e $tag ] ; then
		curl -L "https://github.com/hradec/pipeVFX/archive/$tag.tar.gz" | \
			tar xzv --exclude="golaem" --xform="s/pipeVFX-......pipeline.tools/$tag/x"  pipeVFX-$tag/pipeline/tools
			mv pipeVFX-$tag/pipeline/tools $tag
			rm -rf pipeVFX-$tag

			# upload to server
			sudo rsync -avpP ./$tag/ $server:/atomo/pipeline/tags/$tag/
			ssh 192.168.0.12 " cd /atomo/pipeline/tags/ ; sudo rm -f latest ; sudo ln -s $(ls | egrep '.*\..*\..*' |  sort  -V | tail -1) latest "
	fi
done

#!/bin/bash

CD=$(dirname $(readlink -f $BASH_SOURCE))
cd $CD/pipeline/tags/

# loop over tags and creates the tag folders pulling the tar file from the github releases
git tag | while read tag ; do 
	echo $tag
	echo "https://github.com/hradec/pipeVFX/archive/$tag.tar.gz"
	curl -L "https://github.com/hradec/pipeVFX/archive/$tag.tar.gz" | \
		tar xzv --exclude="golaem" --xform="s/pipeVFX-......pipeline.tools/$tag/x"  pipeVFX-$tag/pipeline/tools
done


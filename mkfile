MKSHELL=/bin/bash

# Load configurations from file 
< config.mk

# Identifying structural variants using SvABA.
results/%:: data/%.bam
	set -x
	mkdir -p $(dirname $target)
	svaba run \
                -t $prereq \
                -p $NT \
                -L $MR \
                -I \
                -a "results/"$stem".build" \
                -G $REFERENCE \
	&& for file in results/*
	do
	NEWNAME=`echo $file | sed "s#.build##"`
	mv -- "$file" "$NEWNAME"
	done

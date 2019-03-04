#!/bin/bash

#ATTENTION: this script moves the mp3's!

#For other setup and library details, see tagger.sh

extract_tag() {
    tag=$1
    echo "$info" | grep $tag: | cut -f2 -d: | tr -d ' '
}

for i in $SOURCEDIR/*.mp3; do
    echo Processing file: "$i"
    info=$(python -u /autotagger/beet.py -v info "$i")
    genre=$(extract_tag genre | sed 's/,/\//')
    styleone=$(extract_tag styleone)
    styletwo=$(extract_tag styletwo)
    stylethree=$(extract_tag stylethree)
    dest_suf="$genre/$styleone/$styletwo/$stylethree"
    if [ ! "$dest_suf" = '///' ]; then
	dest="$SOURCEDIR/$dest_suf"
	echo Moving file: "$i" to subdirectory: "$dest"
	mkdir -p "$dest"
	mv "$i" "$dest"
    else
	echo No genre or style information for file: "$i", skipping
    fi
done

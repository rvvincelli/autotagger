#!/bin/bash

#ATTENTION: this script edits the mp3's in-place! To be used with docker-autotagger only.

db=/autotagger/musiclibrary.blb

IFS=$'\n'

for i in $(cat $INPUTFILE); do
    echo Processing file: "$i"
    search_string="$(echo $i | sed -e s/.mp3// -e 's/\<Anthologia Electronica\> -.*,//g' -e 's/\<Neomelodica\>//g' -e 's/\<The Last Loveparade\>//g' -e 's/\<Ricardo Villalobos feat Luciano\>//g' -e 's/\<Ha Vinto Sanremo\>//' -e 's/\<GTA OST\>//' -e "s/\<L'Hotel Paris OST\>//" -e 's/\<Canal House Amsterdam OST\>//' -e 's/\&//g' -e 's/ vs / /g' -e 's/ feat / /g' -e 's/ pt / /g' -e 's/ mix / /g' -e 's/ rmx / /g' -e 's/(//g' -e 's/)//g' -e 's/-//g' -e 's/,//g' -e 's/\.//g')"
    echo Search string: $search_string
    id=$(ogs search "$search_string" | grep -o '\[.*]' | cut -f 2 -d [ | cut -f 1 -d ] | awk 'NR==2{print $1}') #what is the switch for capture groups in perl style for bsd grep?
    echo ID $id
    if [[ ! -z "${id// }" ]]; then
        rm -f $db
	echo A | python -u /autotagger/beet.py -v import "$SOURCEDIR/$i" -CS $id
	python -u /autotagger/beet.py -v info "$SOURCEDIR/$i"
    else
	echo "$i - NO RECORD FOUND"
    fi
    
done

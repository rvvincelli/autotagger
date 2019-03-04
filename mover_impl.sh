#!/bin/bash 

#To be invoked by mover.sh only.

destdir="$1"
mp3file="$2"

path=$(dirname "$mp3file")
mkdir -p "$destdir/$path"
cp "$mp3file" "$destdir/$path"


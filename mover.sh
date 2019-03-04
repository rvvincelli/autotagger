#!/bin/bash

#ATTENTION: this script moves the mp3's!

cp /autotagger/mover_impl.sh "$SOURCEDIR"

cd "$SOURCEDIR"

find . -name '*.mp3' -exec ./mover_impl.sh "$DESTDIR" {} \;

rm mover_impl.sh

cd -

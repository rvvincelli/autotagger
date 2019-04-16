#!/bin/sh

cd "${DESTDIR}"
find . -mindepth 2 -name "*.mp3" -exec ln -fs {} . \;
cd -


#!/bin/sh

find "${DESTDIR}" -mindepth 2 -name "*.mp3" -exec ln -s {} "$DESTDIR" \;

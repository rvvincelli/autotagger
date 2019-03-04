#!/bin/sh

ls $SOURCEDIR > $INPUTFILE

/autotagger/tagger.sh $SOURCEDIR $INPUTFILE
/autotagger/bucketer.sh $SOURCEDIR
/autotagger/mover.sh $SOURCEDIR $DESTDIR
/autotagger/create_root_symlinks.sh $DESTDIR

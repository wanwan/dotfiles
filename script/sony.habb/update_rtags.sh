#!/bin/bash

function update_rtags() {
    cd $HOME
    cd $1
}


BASEDIR=$HOME/workspace/hgrm/master/hagoromo
SOUNDDIR=services/soundpostcontrolservice
FRAMEWORKDIR=framework/
BUILDLOGFILE=$HOME/logs/build_ebisu_hagoromo_only_stdout.log
#update_rtags $BASEDIR $BUILDLOGFILE


#for file in `find . -name "*.cc" -exec basename \{\} \;`; do  LINE=`grep $file ~/build_ebisu_hagoromo_only_stdout.log | grep ccache | sed -e 's/ccache //g'`; rc -c $LINE  ; done

cd $BASEDIR
for file in `find ${SOUNDDIR} -name "*.cc" -a -not -name "main.cc" -exec basename \{\} \;`
do
    LINE=`grep $file ${BUILDLOGFILE} | grep ccache | sed -e 's/ccache //g' | sed -e 's/aarch64-poky-linux-//g'`
    if [ -n "$LINE" ]; then
	rc -c $LINE
    fi
done

for file in `find ${FRAMEWORKDIR} -name "*.cc" -a -not -name "main.cc" -exec basename \{\} \;`
do
    LINE=`grep $file ${BUILDLOGFILE} | grep ccache | sed -e 's/ccache //g' | sed -e 's/aarch64-poky-linux-//g'`
    if [ -n "$LINE" ]; then
	rc -c $LINE
    fi    
done

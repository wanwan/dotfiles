#!/bin/bash

HOWMDIR=$HOME/howm.git

#FILENAME=`date "+%Y-%m-%d-000001.txt"`
FILENAME=`date "+%Y-%m-%d-000000.txt"`
YEAR=`date "+%Y"`
MONTH=`date "+%m"`
DAY=`date "+%d"`
DAY_OF_YEAR=`date "+%j"`
DAY_OF_WEEK=`date "+%u"`
DAY_OF_MONTH=`date "+%e"`
WEEK_NUMBER=`date "+%U"`

if [ $# -ne 0 ]; then
    if [[ $1 =~ ([0-9][0-9][0-9][0-9])([0-9][0-9])([0-9][0-9]) ]]; then
	FILENAME=`date -j -f "%Y%m%d" $1 "+%Y-%m-%d-000000.txt"`
	YEAR=`date -j -f "%Y%m%d" $1 "+%Y"`
	MONTH=`date -j -f "%Y%m%d" $1 "+%m"`
	DAY=`date -j -f "%Y%m%d" $1 "+%d"`
	DAY_OF_YEAR=`date -j -f "%Y%m%d" $1 "+%j"`
	DAY_OF_WEEK=`date -j -f "%Y%m%d" $1 "+%u"`
	DAY_OF_MONTH=`date -j -f "%Y%m%d" $1 "+%e"`
	WEEK_NUMBER=`date -j -f "%Y%m%d" $1 "+%U"`
    fi
fi


HOWMFILE=$HOWMDIR/$YEAR/$MONTH/$FILENAME
HOWMFILE_DIR=$HOWMDIR/$YEAR/$MONTH/
SCRIPT_DIR=$(cd $(dirname $0); pwd)

source ${SCRIPT_DIR}/make_howm_todo.sh


if [ ! -d $HOWMFILE_DIR ]; then
    mkdir -p $HOWMFILE_DIR
fi

echo "HOWMFILE: " $HOWMFILE

## make header
touch $HOWMFILE
ret=`make_header $YEAR $MONTH $DAY`
#echo "" >> $HOWMFILE
echo -n -e ${ret} >> $HOWMFILE
echo "" >> $HOWMFILE

#if [ ! -f $HOWM_FILE ]; then
#fi

HOWM_DATE_FORM=${YEAR}-${MONTH}-${DAY}

grep -r -e "\[${HOWM_DATE_FORM}\][+@]" ${HOWMDIR} | awk -F ":" '/2/ {print $2}' | sed -e 's/\[[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}\]+/{ }/' >> $HOWMFILE

## space
echo "" >> $HOWMFILE
echo "" >> $HOWMFILE

## tail emacs variables
ret=`make_tail $YEAR $MONTH $DAY`
echo -n -e ${ret} >> $HOWMFILE


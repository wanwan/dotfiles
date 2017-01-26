#!/bin/bash

HOWMDIR=$HOME/howm.git
NEWLINE=$'\n'

# 与えられた日にちに対しての week no を導出し, その一週間分の task を書き出す
# blog file の書式
#
# = [2017][week][blog] 01
# [2017-01-02 10:01]
#
# == 20170108
# == 20170107
# ......
#


#FILENAME=`date "+%Y-%m-%d-000001.txt"`
YEAR=`date "+%Y"`
MONTH=`date "+%m"`
DAY=`date "+%d"`
DAY_OF_YEAR=`date "+%j"`
DAY_OF_WEEK=`date "+%u"`
DAY_OF_MONTH=`date "+%e"`
WEEK_NUMBER=`date "+%U"`

if [ $# -ne 0 ]; then
    if [[ $1 =~ ([0-9][0-9][0-9][0-9])([0-9][0-9])([0-9][0-9]) ]]; then
	YEAR=`date -j -f "%Y%m%d" $1 "+%Y"`
	MONTH=`date -j -f "%Y%m%d" $1 "+%m"`
	DAY=`date -j -f "%Y%m%d" $1 "+%d"`
	DAY_OF_YEAR=`date -j -f "%Y%m%d" $1 "+%j"`
	DAY_OF_WEEK=`date -j -f "%Y%m%d" $1 "+%u"`
	DAY_OF_MONTH=`date -j -f "%Y%m%d" $1 "+%e"`
	WEEK_NUMBER=`date -j -f "%Y%m%d" $1 "+%U"`
    fi
fi

source make_howm_todo.sh

function make_blog_header() {

    local ret
    
    ret=""
    ret+="= [${YEAR}][week][blog] ${WEEK_NUMBER}${NEWLINE}"
    ret+="[${YEAR}-${MONTH}-${DAY} 00:00]${NEWLINE}"
    ret+="${NEWLINE}"

    echo ${ret}
}


function make_day_task() {
    local year month day
    local day_of_week

    year=$1
    month=$2
    day=$3

    echo "== " ${year}${month}${day} >> $HOWMFILE

    day_of_week=`date -j -f "%Y%m%d" ${year}${month}${day} "+%u"`
    
}

# cf http://stackoverflow.com/questions/15606567/unix-date-how-to-convert-week-number-to-a-date-range-mon-sun
function weekof()
{
    local week=$1 year=$2
    local week_num_of_Jan_1 week_day_of_Jan_1
    local first_Mon
    local date_fmt="%Y-%m-%d"
    local mon tue wed thr fri sat sun

    week_num_of_Jan_1=$(date -j -f "$date_fmt" $year-01-01 +%W)
    week_day_of_Jan_1=$(date -j -f "$date_fmt" $year-01-01 +%u)

    if ((week_num_of_Jan_1)); then
        first_Mon=$year-01-01
    else
        first_Mon=$year-01-$((01 + (7 - week_day_of_Jan_1 + 1) ))
    fi

    mon=$(date -v+$((week - 1))w       -j -f "$date_fmt" "$first_Mon" "+%Y%m%d" )
    tue=$(date -v+$((week - 1))w -v+1d -j -f "$date_fmt" "$first_Mon" "+%Y%m%d" )
    wed=$(date -v+$((week - 1))w -v+2d -j -f "$date_fmt" "$first_Mon" "+%Y%m%d" )
    thr=$(date -v+$((week - 1))w -v+3d -j -f "$date_fmt" "$first_Mon" "+%Y%m%d" )
    fri=$(date -v+$((week - 1))w -v+4d -j -f "$date_fmt" "$first_Mon" "+%Y%m%d" )
    sat=$(date -v+$((week - 1))w -v+5d -j -f "$date_fmt" "$first_Mon" "+%Y%m%d" )
    sun=$(date -v+$((week - 1))w -v+6d -j -f "$date_fmt" "$first_Mon" "+%Y%m%d" )
    //echo "\"$mon\" - \"$sun\""
    echo $mon
    echo $tue
    echo $wed
    echo $thr
    echo $fri
    echo $sat
    echo $sun
}


function calc_weekday()
{
    local week=$1 year=$2
    local week_num_of_Jan_1 week_day_of_Jan_1
    local first_Mon
    local date_fmt="%Y-%m-%d"
    local mon tue wed thr fri sat

    week_num_of_Jan_1=$(date -j -f "$date_fmt" $year-01-01 +%W)
    week_day_of_Jan_1=$(date -j -f "$date_fmt" $year-01-01 +%u)

    if ((week_num_of_Jan_1)); then
        first_Mon=$year-01-01
    else
        first_Mon=$year-01-$((01 + (7 - week_day_of_Jan_1 + 1) ))
    fi

    mon=$(date -v+$((week - 1))w            -j -f "$date_fmt" "$first_Mon" "+%Y%m%d" )
    tue=$(date -v+$((week - 1))w    -v+1d   -j -f "$date_fmt" "$first_Mon" "+%Y%m%d" )
    wed=$(date -v+$((week - 1))w    -v+2d   -j -f "$date_fmt" "$first_Mon" "+%Y%m%d" )
    thr=$(date -v+$((week - 1))w    -v+3d   -j -f "$date_fmt" "$first_Mon" "+%Y%m%d" )
    fri=$(date -v+$((week - 1))w    -v+4d   -j -f "$date_fmt" "$first_Mon" "+%Y%m%d" )
    sat=$(date -v+$((week - 1))w    -v+5d   -j -f "$date_fmt" "$first_Mon" "+%Y%m%d" )
    sun=$(date -v+$((week - 1))w    -v+6d   -j -f "$date_fmt" "$first_Mon" "+%Y%m%d" )

    echo "${mon} ${tue} ${wed} ${thr} ${fri} ${sat} ${sun}"
}


DAYS=(`calc_weekday ${WEEK_NUMBER} ${YEAR}`)

MONDAY_STR=${DAYS[0]}
TUESDAY_STR=${DAYS[1]}
WEDNESDAY_STR=${DAYS[2]}
THURSDAY_STR=${DAYS[3]}
FRIDAY_STR=${DAYS[4]}
SATDAY_STR=${DAYS[5]}
SUNDAY_STR=${DAYS[6]}

MONDAY_YEAR=${MONDAY_STR:0:4}
MONDAY_MONTH=${MONDAY_STR:4:2}
MONDAY_DAY=${MONDAY_STR:6:2}

TUESDAY_YEAR=${TUESDAY_STR:0:4}
TUESDAY_MONTH=${TUESDAY_STR:4:2}
TUESDAY_DAY=${TUESDAY_STR:6:2}

WEDNESDAY_YEAR=${WEDNESDAY_STR:0:4}
WEDNESDAY_MONTH=${WEDNESDAY_STR:4:2}
WEDNESDAY_DAY=${WEDNESDAY_STR:6:2}

THURSDAY_YEAR=${THURSDAY_STR:0:4}
THURSDAY_MONTH=${THURSDAY_STR:4:2}
THURSDAY_DAY=${THURSDAY_STR:6:2}

FRIDAY_YEAR=${FRIDAY_STR:0:4}
FRIDAY_MONTH=${FRIDAY_STR:4:2}
FRIDAY_DAY=${FRIDAY_STR:6:2}

SATDAY_YEAR=${SATDAY_STR:0:4}
SATDAY_MONTH=${SATDAY_STR:4:2}
SATDAY_DAY=${SATDAY_STR:6:2}

SUNDAY_YEAR=${SUNDAY_STR:0:4}
SUNDAY_MONTH=${SUNDAY_STR:4:2}
SUNDAY_DAY=${SUNDAY_STR:6:2}


#FILENAME=`date "+%Y-%m-%d-000001.txt"`
FILENAME=${MONDAY_YEAR}-${MONDAY_MONTH}-${MONDAY_DAY}"-000002.txt"

HOWMFILE=$HOWMDIR/$YEAR/$MONTH/$FILENAME
HOWMFILE_DIR=$HOWMDIR/$YEAR/$MONTH/

if [ ! -d $HOWMFILE_DIR ]; then
    mkdir -p $HOWMFILE_DIR
fi

#weekof ${WEEK_NUMBER} ${YEAR}

echo "HOWMFILE: " $HOWMFILE

## make header
touch $HOWMFILE
ret=`make_blog_header`
echo -n -e ${ret} >> $HOWMFILE

make_day_task ${MONDAY_YEAR} ${MONDAY_MONTH} ${MONDAY_DAY}

make_day_task ${TUESDAY_YEAR} ${TUESDAY_MONTH} ${TUESDAY_DAY}

make_day_task ${WEDNESDAY_YEAR} ${WEDNESDAY_MONTH} ${WEDNESDAY_DAY}

make_day_task ${THURSDAY_YEAR} ${THURSDAY_MONTH} ${THURSDAY_DAY}

make_day_task ${FRIDAY_YEAR} ${FRIDAY_MONTH} ${FRIDAY_DAY}

make_day_task ${SATDAY_YEAR} ${SATDAY_MONTH} ${SATDAY_DAY}

make_day_task ${SUNDAY_YEAR} ${SUNDAY_MONTH} ${SUNDAY_DAY}

echo "" >> $HOWMFILE
echo "" >> $HOWMFILE

## tail emacs variables
ret=`make_tail $YEAR $MONTH $DAY`
echo -e ${ret} >> $HOWMFILE

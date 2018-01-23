#!/bin/bash

HOWMDIR=$HOME/howm.git
NEWLINE=$'\n'
DATE=date
if [ -x /usr/local/bin/gdate ]; then
    DATE=gdate
fi

# 与えられた日にちに対しての week no を導出し, その一週間分の task を書き出す
# todo file の書式
#
# = [2017][week][todo] 01
# [2017-01-02 10:01]
#
# == 20170108
# == 20170107
# ......
#


#FILENAME=`${DATE} "+%Y-%m-%d-000001.txt"`
YEAR=`${DATE} "+%Y"`
MONTH=`${DATE} "+%m"`
DAY=`${DATE} "+%d"`
DAY_OF_YEAR=`${DATE} "+%j"`
DAY_OF_WEEK=`${DATE} "+%u"`
DAY_OF_MONTH=`${DATE} "+%e"`
_WEEK_NUMBER=$((`${DATE} "+%U"` + 1))
WEEK_NUMBER=`printf %02d $_WEEK_NUMBER`

if [ $# -ne 0 ]; then
    if [[ $1 =~ ([0-9][0-9][0-9][0-9])([0-9][0-9])([0-9][0-9]) ]]; then
	YEAR=`${DATE} -d $1 "+%Y"`
	MONTH=`${DATE} -d $1 "+%m"`
	DAY=`${DATE} -d $1 "+%d"`
	DAY_OF_YEAR=`${DATE} -d $1 "+%j"`
	DAY_OF_WEEK=`${DATE} -d $1 "+%u"`
	DAY_OF_MONTH=`${DATE} -d $1 "+%e"`
	WEEK_NUMBER=`${DATE} -d $1 "+%U"`
    fi
fi

SCRIPT_DIR=$(cd $(dirname $0); pwd)

source ${SCRIPT_DIR}/make_howm_todo.sh

function make_todo_header() {

    local ret
    
    ret=""
    ret+="= [${YEAR}][week][todo] ${WEEK_NUMBER}${NEWLINE}"
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

    day_of_week=`${DATE} -d ${year}${month}${day} "+%u"`

    # common task
    ## morning
    ret=`make_morning_task ${year} ${month} ${day}`
    echo -n -e ${ret} >> $HOWMFILE

    ## noon
    ret=`make_afternoon_task ${year} ${month} ${day}`
    echo -n -e ${ret} >> $HOWMFILE

    ## evening
    ret=`make_evening_task ${year} ${month} ${day}`
    echo -n -e ${ret} >> $HOWMFILE

    ## weekend
    ret=`make_weekend_task ${year} ${month} ${day}`
    echo -n -e ${ret} >> $HOWMFILE

    ## monthly
    ret=`make_monthly_task ${year} ${month} ${day}`
    echo -n -e ${ret} >> $HOWMFILE

    ## theme(special)
    ret=`make_theme ${year} ${month} ${day}`
    echo -n -e ${ret} >> $HOWMFILE

    ## study(special)
    ret=`make_study ${year} ${month} ${day}`
    echo -n -e ${ret} >> $HOWMFILE
    
    case ${day_of_week} in
	# weekday
	1|2|3|4|5)
	    #echo "weekday"
	    ;;
	# weekend
	*)
	    #echo "weekend"
	    ;;
    esac
    
    case ${day_of_week} in
	#monday
	1)
	    make_monday_task
	    ;;
	#tuesday
	2)
	    make_tuesday_task
	    ;;
	#wednesday
	3)
	    make_wednesday_task
	    ;;
	#thursday
	4)
	    make_thursday_task
	    ;;
	#friday
	5)
	    make_friday_task
	    ;;
	#satday
	6)
	    make_satday_task
	    ;;	
	#sunday
	7)
	    make_sunday_task
	    ;;		
    esac
}

function make_monday_task() {
    #echo "monday" >> $HOWMFILE
    echo ""
}

function make_tuesday_task() {
    #echo "tuesday" >> $HOWMFILE
    echo ""
}

function make_wednesday_task() {
    #echo "wednesday" >> $HOWMFILE
    echo ""
}

function make_thursday_task() {
    #echo "thursday" >> $HOWMFILE
    echo ""    
}

function make_friday_task() {
    #echo "friday" >> $HOWMFILE
    echo ""
}

function make_satday_task() {
    #echo "satday" >> $HOWMFILE
    echo ""
}

function make_sunday_task() {
    #echo "sunday" >> $HOWMFILE
    echo ""
}


# cf http://stackoverflow.com/questions/15606567/unix-date-how-to-convert-week-number-to-a-date-range-mon-sun
function weekof()
{
    local week=$1 year=$2
    local week_num_of_Jan_1 week_day_of_Jan_1
    local first_Mon
    local date_fmt="%Y-%m-%d"
    local mon tue wed thr fri sat sun

    week_num_of_Jan_1=$(${DATE} -d $year-01-01 +%W)
    week_day_of_Jan_1=$(${DATE} -d $year-01-01 +%u)

    if ((week_num_of_Jan_1)); then
        first_Mon=$year-01-01
    else
        first_Mon=$year-01-$((01 + (7 - week_day_of_Jan_1 + 1) ))
    fi

    mon=$(${DATE} -v+$((week - 1))w       -j -f "$date_fmt" "$first_Mon" "+%Y%m%d" )
    tue=$(${DATE} -v+$((week - 1))w -v+1d -j -f "$date_fmt" "$first_Mon" "+%Y%m%d" )
    wed=$(${DATE} -v+$((week - 1))w -v+2d -j -f "$date_fmt" "$first_Mon" "+%Y%m%d" )
    thr=$(${DATE} -v+$((week - 1))w -v+3d -j -f "$date_fmt" "$first_Mon" "+%Y%m%d" )
    fri=$(${DATE} -v+$((week - 1))w -v+4d -j -f "$date_fmt" "$first_Mon" "+%Y%m%d" )
    sat=$(${DATE} -v+$((week - 1))w -v+5d -j -f "$date_fmt" "$first_Mon" "+%Y%m%d" )
    sun=$(${DATE} -v+$((week - 1))w -v+6d -j -f "$date_fmt" "$first_Mon" "+%Y%m%d" )
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

    week_num_of_Jan_1=$(${DATE} -d $year-01-01 +%W)
    week_day_of_Jan_1=$(${DATE} -d $year-01-01 +%u)

    if ((week_num_of_Jan_1)); then
        first_Mon=$year-01-01
    else
        first_Mon=$year-01-$((01 + (7 - week_day_of_Jan_1 + 1) ))
    fi

    mon=$(${DATE} -d "$((week - 1)) weeks        $first_Mon" "+%Y%m%d" )
    tue=$(${DATE} -d "$((week - 1)) weeks 1 day  $first_Mon" "+%Y%m%d" )
    wed=$(${DATE} -d "$((week - 1)) weeks 2 day  $first_Mon" "+%Y%m%d" )
    thr=$(${DATE} -d "$((week - 1)) weeks 3 day  $first_Mon" "+%Y%m%d" )
    fri=$(${DATE} -d "$((week - 1)) weeks 4 day  $first_Mon" "+%Y%m%d" )
    sat=$(${DATE} -d "$((week - 1)) weeks 5 day  $first_Mon" "+%Y%m%d" )
    sun=$(${DATE} -d "$((week - 1)) weeks 6 day  $first_Mon" "+%Y%m%d" )

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


#FILENAME=`${DATE} "+%Y-%m-%d-000001.txt"`
FILENAME=${MONDAY_YEAR}-${MONDAY_MONTH}-${MONDAY_DAY}"-000001.txt"

HOWMFILE=$HOWMDIR/$YEAR/$MONTH/$FILENAME
HOWMFILE_DIR=$HOWMDIR/$YEAR/$MONTH/

if [ ! -d $HOWMFILE_DIR ]; then
    mkdir -p $HOWMFILE_DIR
fi

#weekof ${WEEK_NUMBER} ${YEAR}

echo "HOWMFILE: " $HOWMFILE

## make header
touch $HOWMFILE
ret=`make_todo_header`
echo -e ${ret} >> $HOWMFILE

make_day_task ${MONDAY_YEAR} ${MONDAY_MONTH} ${MONDAY_DAY}
echo "" >> $HOWMFILE

make_day_task ${TUESDAY_YEAR} ${TUESDAY_MONTH} ${TUESDAY_DAY}
echo "" >> $HOWMFILE

make_day_task ${WEDNESDAY_YEAR} ${WEDNESDAY_MONTH} ${WEDNESDAY_DAY}
echo "" >> $HOWMFILE

make_day_task ${THURSDAY_YEAR} ${THURSDAY_MONTH} ${THURSDAY_DAY}
echo "" >> $HOWMFILE

make_day_task ${FRIDAY_YEAR} ${FRIDAY_MONTH} ${FRIDAY_DAY}
echo "" >> $HOWMFILE

make_day_task ${SATDAY_YEAR} ${SATDAY_MONTH} ${SATDAY_DAY}
echo "" >> $HOWMFILE

make_day_task ${SUNDAY_YEAR} ${SUNDAY_MONTH} ${SUNDAY_DAY}
echo "" >> $HOWMFILE



## tail emacs variables
ret=`make_tail $YEAR $MONTH $DAY`
echo -e ${ret} >> $HOWMFILE

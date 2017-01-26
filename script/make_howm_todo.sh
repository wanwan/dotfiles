
#NEWLINE=$'\n'
NEWLINE='\n'
DATE=date

function make_header() {

    local year month day
    local ret
    year=$1
    month=$2
    day=$3
    
    ret="= ${year}_${month}_${day}${NEWLINE}"
    ret+="[${year}-${month}-${day} 00:00]${NEWLINE}"

    echo ${ret}
}

function get_day_of_week_from_yyyy_mm_dd() {

    local year month day
    local day_of_week
    year=$1
    month=$2
    day=$3

    day_of_week=`${DATE} -d ${year}${month}${day} "+%u"`
    echo ${day_of_week}
}


function make_morning_task() {

    local year month day
    local day_of_week
    local ret

    year=$1
    month=$2
    day=$3

    day_of_week=`get_day_of_week_from_yyyy_mm_dd $year $month $day`
    ret=""
    
    # every day
    ret+="{ } 身嗜み (歯磨き/洗顔/髭)${NEWLINE}"
    ret+="{ } 体重測定${NEWLINE}"
    ret+="{ } 食洗機${NEWLINE}"
    ret+="{ } 洗濯機${NEWLINE}"
    
    ret+="{ } feedly newsfeed check${NEWLINE}"
    ret+="{ } 英語${NEWLINE}"
    ret+="{ } トレーニング${NEWLINE}"
    ret+="{ } ingress${NEWLINE}"
    ret+="{ } フィットネス用準備${NEWLINE}"
    ret+="{ } 充電 (携帯電話/iphone/earphone/router/外部バッテリ/ノートパソコン)${NEWLINE}"

    ret+="{ } 翌日用 TODO 整理${NEWLINE}"

    # weekday
    # some weekday (1:Monday ... 6:Saturday,7:Sunday)
    # Monday
    if [ $day_of_week == 1 ]; then
        ret+="{ } 清掃 (15min)${NEWLINE}"
    fi
    # Tuesday
    if [ $day_of_week == 2 ]; then
        ret+="{ } 清掃 (15min)${NEWLINE}"
    fi
    # Wednesday
    if [ $day_of_week == 3 ]; then
        ret+="{ } 清掃 (15min)${NEWLINE}"
    fi
    # Thursday
    if [ $day_of_week == 4 ]; then
        ret+="{ } 清掃 (15min)${NEWLINE}"
    fi
    # Friday
    if [ $day_of_week == 5 ]; then
        ret+="{ } 清掃 (15min)${NEWLINE}"
    fi
    # weekend
    # Saturday
    if [ $day_of_week == 6 ]; then
        ret+="{ } 清掃 (1hr)${NEWLINE}"
    fi
    # Sunday
    if [ $day_of_week == 7 ]; then
        ret+="{ } 清掃 (1hr)${NEWLINE}"
    fi

    echo ${ret}
}


function make_afternoon_task() {

    local year month day
    local ret

    year=$1
    month=$2
    day=$3

    ret=""
    
    # every day
    ret+="{ } 小説${NEWLINE}"
    ret+="{ } ストレッチ${NEWLINE}"
    # weekday

    echo ${ret}
}


function make_evening_task() {

    local year month day
    local day_of_year
    local day_of_week
    local ret
    
    year=$1
    month=$2
    day=$3

    day_of_year=`${DATE} -d ${year}${month}${day} "+%j"`
    day_of_week=`get_day_of_week_from_yyyy_mm_dd $year $month $day`    

    ret=""    
    
    # every day
    ret+="{ } 翌朝用コーヒーメーカー設定${NEWLINE}"
    ret+="{ } 翌朝用風呂設定${NEWLINE}"
    # weekday
    # even/odd day
    if [ `expr $day_of_year % 2` == 0 ]; then
        # "even"
	#ret+="{ } github 更新${NEWLINE}"
	ret+=""
        #echo
    else
        # "odd"
        #ret+="{ } 風呂掃除${NEWLINE}"
	ret+="{ } blog 更新${NEWLINE}"
    fi
    # day by 3 day
    if [ `expr $day_of_year % 3` == 0 ]; then
        # day 1
        #echo "{ } LDK 清掃" >> $HOWMFILE
	echo ""
    elif [ `expr $day_of_year % 3` == 1 ]; then
        # day 2
        ret+="{ } ゴミ出し${NEWLINE}"
    else
        # day 3
        ret+="{ } 洗濯物整理${NEWLINE}"
    fi

    # some weekday (1:Monday ... 6:Saturday,7:Sunday)
    # Sunday
    if [ $day_of_week == 7 ]; then
        #echo "Sunday"
        #ret+="{ } 購入 (食材類:xxx)${NEWLINE}"
        ret+="{ } 翌日用弁当作成${NEWLINE}"
	ret+="{ } 会社用水出しコーヒー補充${NEWLINE}"	
    fi
    # Monday
    if [ $day_of_week == 1 ]; then
        #echo "Monday"
        ret+="{ } 翌日用弁当作成${NEWLINE}"
	ret+="{ } 会社用水出しコーヒー補充${NEWLINE}"	
    fi
    # Tuesday
    if [ $day_of_week == 2 ]; then
        #echo "Tuesday"
        ret+="{ } 翌日用弁当作成${NEWLINE}"
	ret+="{ } 会社用水出しコーヒー補充${NEWLINE}"
    fi
    # Wednesday
    if [ $day_of_week == 3 ]; then
	#echo "Wednesday"
	#ret+="{ } 購入 (食材類:xxx)"
	ret+="{ } 翌日用弁当作成${NEWLINE}"
	ret+="{ } 会社用水出しコーヒー補充${NEWLINE}"
    fi
    # Thursday
    if [ $day_of_week == 4 ]; then
	#echo "Thursday"
	ret+="{ } 翌日用弁当作成${NEWLINE}"
	ret+="{ } 会社用水出しコーヒー補充${NEWLINE}"
    fi
    # Friday
    if [ $day_of_week == 5 ]; then
	#echo "Friday"
	#ret+="{ } 購入 (食材類:xxx)${NEWLINE}"
	ret+=""
    fi
    # Saturday
    if [ $day_of_week == 6 ]; then
	#echo "Friday"
	ret+="{ } 購入 (食材類:xxx)${NEWLINE}"
    fi
    
    echo ${ret}
}


function make_weekend_task() {

    local year month day
    local day_of_week
    local week_number
    local ret
    
    year=$1
    month=$2
    day=$3

    day_of_week=`get_day_of_week_from_yyyy_mm_dd $year $month $day`    
    week_number=`${DATE} -d ${year}${month}${day} "+%U"`
    ret=""
    
    # Saturday (Weekend Task is here)
    if [ $day_of_week == 6 ]; then
	#echo "Saturday"
	ret+="{ } 家計簿記入${NEWLINE}"
        ret+="{ } 夜食用冷凍おにぎり作成${NEWLINE}"
	ret+="{ } 弁当用おかず整理/作成${NEWLINE}"
	ret+="{ } 冷蔵庫整理${NEWLINE}"
	ret+="{ } ビデオ整理${NEWLINE}"
    fi

    # Weekend/Even
    if [ $day_of_week == 6 -a `expr $week_number % 2` == 0 ]; then
	ret+="{ } トイレ掃除${NEWLINE}"
	ret+="{ } アイロン${NEWLINE}"
    fi

    # Weekend/Odd
    if [ $day_of_week == 6 -a `expr $week_number % 2` == 1 ]; then
	ret+="{ } ロードレーサーメンテナンス(タイヤ/チェーンクリーニング/オイル)${NEWLINE}"
    fi

    echo ${ret}
}


function make_monthly_task() {

    local year month day
    local day_of_month
    local ret
    
    year=$1
    month=$2
    day=$3

    day_of_month=`${DATE} -d ${year}${month}${day} "+%e"`
    ret=""
    
    # 1st day of Month
    if [ $day_of_month == 1 ]; then
	ret+="{ } 購入 (洋服類)${NEWLINE}"
    fi

    # mid day of Month
    if [ $day_of_month == 15 ]; then
	ret+="{ } 洗濯機掃除${NEWLINE}"
	ret+="{ } 革製品メンテナンス(鞄類)${NEWLINE}"
    fi

    # end day of Month
    if [ $day_of_month == 25 ]; then
	ret+="{ } 確定拠出年金見直し${NEWLINE}"
	ret+="{ } 革製品メンテナンス(靴類)${NEWLINE}"
    fi

    echo ${ret}
}

function make_tail() {

    local year month day
    local ret
    
    year=$1
    month=$2
    day=$3
    ret=""
    
    # local-variables
    ret+="Local Variables:${NEWLINE}"
    ret+="coding: utf-8${NEWLINE}"
    ret+="End:${NEWLINE}"

    echo ${ret}    
}

function make_theme() {

    local year month day
    local ret
    
    year=$1
    month=$2
    day=$3
    ret=""
    
    #echo "[テーマ]" >> $HOWMFILE
    ret+="{ } [テーマ] media(R5RS) まとめ${NEWLINE}"

    echo ${ret}
}

function make_study() {

    local year month day
    local ret
    
    year=$1
    month=$2
    day=$3
    ret=""
    
    #echo "{ } [study] 情報処理試験勉強" >> $HOWMFILE
    ret+="{ } [study] javascript${NEWLINE}"

    echo ${ret}
}



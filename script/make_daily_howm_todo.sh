#!/bin/bash

HOWMDIR=$HOME/howm.git
FILENAME=`date -v+1d "+%Y-%m-%d-000000.txt"`
YEAR=`date -v+1d "+%Y"`
MONTH=`date -v+1d "+%m"`
DAY=`date -v+1d "+%d"`
DAY_OF_YEAR=`date -v+1d "+%j"`
DAY_OF_WEEK=`date -v+1d "+%u"`
DAY_OF_MONTH=`date -v+1d "+%e"`
WEEK_NUMBER=`date -v+1d "+%U"`

HOWMFILE=$HOWMDIR/$YEAR/$MONTH/$FILENAME
HOWMFILE_DIR=$HOWMDIR/$YEAR/$MONTH/

make_header() {
    echo "= <<< ${YEAR}_${MONTH}_${DAY}" > $HOWMFILE
    echo "[${YEAR}-${MONTH}-${DAY} 00:00]" >> $HOWMFILE
    echo "" >> $HOWMFILE
}

make_morning_task() {

    # every day
    echo "{ } 身嗜み (歯磨き/洗顔/髭)" >> $HOWMFILE
    echo "{ } 食洗機" >> $HOWMFILE
    echo "{ } 洗濯機" >> $HOWMFILE

    echo "{ } feedly newsfeed check" >> $HOWMFILE
    echo "{ } 英語" >> $HOWMFILE
    echo "{ } トレーニング" >> $HOWMFILE
    echo "{ } ingress" >> $HOWMFILE
    echo "{ } フィットネス用準備" >> $HOWMFILE
    echo "{ } 充電 (携帯電話/iphone/earphone/router/外部バッテリ/ノートパソコン)" >> $HOWMFILE

    # weekday
    # some weekday (1:Monday ... 6:Saturday,7:Sunday)
    # Monday
    if [ $DAY_OF_WEEK == 1 ]; then
        echo "{ } 清掃 (15min)" >> $HOWMFILE
    fi
    # Tuesday
    if [ $DAY_OF_WEEK == 2 ]; then
        echo "{ } 清掃 (15min)" >> $HOWMFILE
    fi
    # Wednesday
    if [ $DAY_OF_WEEK == 3 ]; then
        echo "{ } 清掃 (15min)" >> $HOWMFILE
    fi
    # Thursday
    if [ $DAY_OF_WEEK == 4 ]; then
        echo "{ } 清掃 (15min)" >> $HOWMFILE
    fi
    # Friday
    if [ $DAY_OF_WEEK == 5 ]; then
        echo "{ } 清掃 (15min)" >> $HOWMFILE
    fi
    # weekend
    # Saturday
    if [ $DAY_OF_WEEK == 6 ]; then
        echo "{ } 清掃 (1hr)" >> $HOWMFILE
    fi
    # Sunday
    if [ $DAY_OF_WEEK == 7 ]; then
        echo "{ } 清掃 (1hr)" >> $HOWMFILE
    fi
}

make_afternoon_task() {
    # every day
    echo "{ } 小説" >> $HOWMFILE
    echo "{ } ストレッチ" >> $HOWMFILE
    # weekday
}

make_evening_task() {
    # every day
    echo 
    # weekday
    # even/odd day
    if [ `expr $DAY_OF_YEAR % 2` == 0 ]; then
        # "even"
	echo "{ } github 更新" >> $HOWMFILE
        #echo
    else
        # "odd"
        echo "{ } 風呂掃除" >> $HOWMFILE
	echo "{ } blog 更新" >> $HOWMFILE
    fi
    # day by 3 day
    if [ `expr $DAY_OF_YEAR % 3` == 0 ]; then
        # day 1
        #echo "{ } LDK 清掃" >> $HOWMFILE
	echo ""
    elif [ `expr $DAY_OF_YEAR % 3` == 1 ]; then
        # day 2
        echo "{ } ゴミ出し" >> $HOWMFILE
    else
        # day 3
        echo "{ } 洗濯物整理" >> $HOWMFILE
    fi

    # some weekday (1:Monday ... 6:Saturday,7:Sunday)
    # Sunday
    if [ $DAY_OF_WEEK == 7 ]; then
        echo "Sunday"
        echo "{ } 購入 (食材類:xxx)" >> $HOWMFILE
        echo "{ } 翌日用弁当作成" >> $HOWMFILE
    fi
    # Monday
    if [ $DAY_OF_WEEK == 1 ]; then
        echo "Monday"
        echo "{ } 翌日用弁当作成" >> $HOWMFILE
    fi
    # Tuesday
    if [ $DAY_OF_WEEK == 2 ]; then
        echo "Tuesday"
        echo "{ } 翌日用弁当作成" >> $HOWMFILE
    fi
    # Wednesday
    if [ $DAY_OF_WEEK == 3 ]; then
	echo "Wednesday"
	echo "{ } 購入 (食材類:xxx)" >> $HOWMFILE
	echo "{ } 翌日用弁当作成" >> $HOWMFILE
    fi
    # Thursday
    if [ $DAY_OF_WEEK == 4 ]; then
	echo "Thursday"
	echo "{ } 翌日用弁当作成" >> $HOWMFILE
    fi
    # Friday
    if [ $DAY_OF_WEEK == 5 ]; then
	echo "Friday"
	echo "{ } 購入 (食材類:xxx)" >> $HOWMFILE
    fi
}

make_weekend_task() {
    # Saturday (Weekend Task is here)
    if [ $DAY_OF_WEEK == 6 ]; then
	echo "Saturday"
	echo "{ } 家計簿記入" >> $HOWMFILE
    #    echo "{ } 夜食用冷凍おにぎり作成" >> $HOWMFILE
	echo "{ } 弁当用おかず整理/作成" >> $HOWMFILE
	echo "{ } 冷蔵庫整理" >> $HOWMFILE
	echo "{ } ビデオ整理" >> $HOWMFILE
    fi

    # Weekend/Even
    if [ $DAY_OF_WEEK == 6 -a `expr $WEEK_NUMBER % 2` == 0 ]; then
	echo "{ } トイレ掃除" >> $HOWMFILE
	echo "{ } アイロン" >> $HOWMFILE
    fi

    # Weekend/Odd
    if [ $DAY_OF_WEEK == 6 -a `expr $WEEK_NUMBER % 2` == 1 ]; then
	echo "{ } ロードレーサーメンテナンス(タイヤ/チェーンクリーニング/オイル)" >> $HOWMFILE
    fi
}


make_monthly_task() {
    # 1st day of Month
    if [ $DAY_OF_MONTH == 1 ]; then
	echo "{ } 購入 (洋服類)" >> $HOWMFILE
	echo "{ } 革製品メンテナンス(黒靴) " >> $HOWMFILE
	echo "{ } 革製品メンテナンス(茶靴) " >> $HOWMFILE
	echo "{ } 革製品メンテナンス(鞄) " >> $HOWMFILE
    fi

    # mid day of Month
    if [ $DAY_OF_MONTH == 15 ]; then
	echo "{ } 洗濯機掃除" >> $HOWMFILE
    fi

    # end day of Month
    if [ $DAY_OF_MONTH == 25 ]; then
	echo "{ } 確定拠出年金見直し" >> $HOWMFILE
    fi


}

make_tail() {
    # local-variables
    echo "" >> $HOWMFILE
    echo "" >> $HOWMFILE
    echo "Local Variables:" >> $HOWMFILE
    echo "coding: utf-8" >> $HOWMFILE
    echo "End:" >> $HOWMFILE
}

make_theme() {
    #echo "[テーマ]" >> $HOWMFILE
    echo "{ } [テーマ] media(R5RS) まとめ" >> $HOWMFILE
}

make_study() {
    echo "{ } [study] 情報処理試験勉強" >> $HOWMFILE
}




if [ ! -d $HOWMFILE_DIR ]; then
    mkdir -p $HOWMFILE_DIR
fi

echo "HOWMFILE: " $HOWMFILE

touch $HOWMFILE

## make header
make_header

## morning
make_morning_task
echo "" >> $HOWMFILE

## noon
make_afternoon_task
echo "" >> $HOWMFILE

## evening
make_evening_task
echo "" >> $HOWMFILE

## weekend
make_weekend_task
echo "" >> $HOWMFILE

## monthly
make_monthly_task
echo "" >> $HOWMFILE

## theme(special)
make_theme
echo "" >> $HOWMFILE

## study(special)
make_study
echo "" >> $HOWMFILE

## tail emacs variables
make_tail


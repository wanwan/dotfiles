# arg1 msg
function notify_local() {
    #    notify-send -i /usr/share/icons/gnome/32x32/emotes -u normal "message"
    #notify-send -i /usr/share/icons/gnome/32x32/emotes/face-smile.png -u normal "message"
    notify-send -i /usr/share/icons/gnome/32x32/status/info.png -u normal "$1"
    aplay $HOME/data/system-ready.wav
}

# use pushover to notify android/ipad/notepc
function notify_phone {
    curl -s -F "token=a3m8tmcgsmetjx7t8hsgbw2edvg1ib" -F "user=u4ftprmtkvcfgrs17vtw38dm4vys7f" -F "title=$1" -F "message=$2" https://api.pushover.net/1/messages.json
}

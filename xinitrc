
# mouse accel
xset m 2048 8

#swap caps to ctrl
setxkbmap -option "ctrl:nocaps"

#wall paper
#setroot ~/wallpapers/5290131_p0.jpg
setroot ~/wallpapers/Xmbindings.png

if [ -f ~/.Xresources ]; then
  xrdb -merge ~/.Xresources
fi

export GTK_IM_MODULE='uim'
export QT_IM_MODULE='uim'
uim-xim &
export XMODIFIERS='@im=uim'

#exec awesome
exec xmonad >> /home/waka/tmp/xmonad.log

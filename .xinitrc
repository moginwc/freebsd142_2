#!/bin/sh

export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

export GTK_IM_MODULE=uim
export QT_IM_MODULE=uim
export XMODIFIERS=@im=uim
export XIM=uim
#/usr/local/bin/mozc start
uim-xim &
uim-toolbar-gtk3 -1-1 &

#export WINEDEBUG=-all

#setxkbmap jp

xset r rate 250 40
xset m 5 3
xkbcomp -I$HOME/.xkb ~/.xkb/keymap/mykbd $DISPLAY
##xrdb -merge ~/.Xresources

xsetroot -solid \#5b468f
xclock -update 1 -d -strftime '%Y-%m-%d(%a) %T' -geometry -1+1 -bg \#f8f8f7 &
mlterm -geometry 80x24+1+1 -title="端末エミュレータ" &
#xpad -s &

##autocutsel -selection PRIMARY &
##autocutsel -selection CLIPBOARD &

exec fvwm3

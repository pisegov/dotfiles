#!/usr/bin/env bash

LAYOUT="$(/usr/local/bin/xkbswitch -ge)"
if [ $LAYOUT = "ABC" ]; then
    sketchybar --set $NAME label="US"
elif [ "$(/usr/local/bin/xkbswitch -ge)" = "RussianWin" ]; then
    sketchybar --set $NAME label="RU"
fi

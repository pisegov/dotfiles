#!/usr/bin/env sh

sketchybar --set $NAME label="$(LC_TIME=ru_RU.UTF-8 date +'%a | %d.%m | %H:%M:%S')"

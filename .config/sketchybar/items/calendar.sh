#!/usr/bin/env sh

calendar=(
  icon=􀐫
  icon.font="$FONT:Black:12.0"
  icon.padding_right=0
  # label.width=45
  label="$(LC_TIME=ru_RU.UTF-8 date +'%a | %d.%m | %H:%M:%S')"
  label.align=right
  padding_left=5
  update_freq=1
  script="$PLUGIN_DIR/calendar.sh"
)
echo "$PLUGIN_DIR/calendar.sh"

sketchybar --add item calendar right       \
           --set calendar "${calendar[@]}" \

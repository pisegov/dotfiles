#!/usr/bin/env sh
keyboard=(
  icon=􀺑
  icon.font="$FONT:Black:12.0"
  icon.padding_right=0
  label.align=right
  update_freq=5
  script="$CONFIG_DIR/plugins/keyboard.sh"
)

sketchybar --add event keyboard_layout_change
sketchybar --add item keyboard right \
                  --subscribe keyboard keyboard_layout_change \
                  --set keyboard "${keyboard[@]}" \

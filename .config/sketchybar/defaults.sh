##### Changing Defaults #####
# We now change some default values, which are applied to all further items.
# For a full list of all available item properties see:
# https://felixkratz.github.io/SketchyBar/config/items

default=(
  padding_left=5
  padding_right=5
  icon.font="SF Pro:Semibold:15.0"
  label.font="SF Pro:Semibold:15.0"
  icon.color=0xffffffff
  label.color=0xffffffff
  background.color=$ITEM_BG_COLOR
  background.corner_radius=5
  background.height=24
  icon.padding_left=3
  icon.padding_right=3
  label.padding_left=3
  label.padding_right=3
)
$BAR_NAME --default "${default[@]}"

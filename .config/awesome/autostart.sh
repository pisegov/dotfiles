#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}
run dex $HOME/.config/autostart/arcolinux-welcome-app.desktop

#run xrandr --output VGA-1 --primary --mode 1360x768 --pos 0x0 --rotate normal
#run xrandr --output HDMI2 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off

#autorandr horizontal
run nm-applet
run emacs --daemon
# run light-locker
#run caffeine
#run albert
run syncthing
run workrave
run flameshot
run pamac-tray
# run plank
run xfce4-power-manager
run kdeconnect-indicator
run blueberry-tray
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
run numlockx on
run volumeicon
run nitrogen --restore
run conky -c $HOME/.config/awesome/system-overview
run xhost +local:root
#you can set wallpapers in themes as well
#feh --bg-fill /usr/share/backgrounds/arcolinux/arco-wallpaper.jpg &

#run applications from startup
#run firefox
#run atom
#run dropbox
#run insync start
#run spotify
#run ckb-next -b
#run discord
#run telegram-desktop

# run scripts
# run setxkbmap -layout us,ru # -option grp:alt_shift_toggle
xinput set-prop "ELAN2301:00 04F3:306B Touchpad" "libinput Natural Scrolling Enabled" 1
xinput set-prop "ELAN2301:00 04F3:306B Touchpad" "libinput Accel Speed" 0.3

# run setxkbmap -layout "us+custom(third_layer),ru:2+custom(third_layer)" -print | xkbcomp -I"$HOME/.config/xkb" - "${DISPLAY%%.*}"
# run ~/.screenlayout/default.sh
autorandr -c
run optimus-manager-qt
prime-offload

# touchpad gestures
libinput-gestures-setup start

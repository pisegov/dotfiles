#!/usr/bin/env sh

WG=$(scutil --nc list | grep Connected | sed -E 's/.*"(.*)".*/\1/')
# CISCO=$(/usr/local/bin/check-cisco-connection)
VISCOSITY=$(osascript /Users/m.pisegov/Documents/custom-shell-scripts/list_viscosity_connections.scpt)

if [[ $WG != "" ]]; then
    VPN=$WG
# elif [[ $CISCO != "" ]]; then
#     VPN=$CISCO
elif [[ $VISCOSITY != "" ]]; then
    VPN=$VISCOSITY
fi

if [[ $VPN != "" ]]; then
  sketchybar -m --set vpn icon=􀙧 \
                          label="$VPN" \
                          drawing=on
else
  sketchybar -m --set vpn icon=􀙦 label="off"
fi

#!/bin/sh

PHILIPS_XRANDR="DP1-1-8"
DELL_XRANDR="DP-1.1"
ADAPTER_XRANDR="DP1"

function profile_philips() {
    xmobar -p "Static {xpos = 0, ypos = 0, width = 3440, height = 32 }" /home/bernhard/.config/xmobar/xmobarrc_primary &
}

function profile_philips_and_dell() {
    xmobar -p "Static {xpos = 1920, ypos = 0, width = 3440, height = 32 }" /home/bernhard/.config/xmobar/xmobarrc_primary &
    xmobar -p "Static {xpos = 0, ypos = 0, width = 1920, height = 26 }" /home/bernhard/.config/xmobar/xmobarrc_secondary &
}

function is_dell_connected() {
    [ -n "$(xrandr | grep "^$DELL_XRANDR connected")" ]
}

killall xmobar

if is_dell_connected; then
    echo "Switching to philips and dell profile..."
    profile_philips_and_dell
else
    echo "Switching to philips profile..."
    profile_philips
fi

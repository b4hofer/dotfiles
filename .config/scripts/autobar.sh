#!/bin/sh

PHILIPS_XRANDR="DP1-1-8"
DELL_XRANDR="DP1-1-1"
ADAPTER_XRANDR="DP1"

function profile_laptop() {
    xmobar -p "Static {xpos = 0, ypos = 0, width = 3000, height = 52 }" /home/bernhard/.config/xmobar/xmobarrc_primary &
}

function profile_philips() {
    xmobar -p "Static {xpos = 0, ypos = 0, width = 3440, height = 32 }" /home/bernhard/.config/xmobar/xmobarrc_primary &
}

function profile_docked() {
    xmobar -p "Static {xpos = 1920, ypos = 0, width = 3440, height = 32 }" /home/bernhard/.config/xmobar/xmobarrc_primary &
    xmobar -p "Static {xpos = 0, ypos = 0, width = 1920, height = 26 }" /home/bernhard/.config/xmobar/xmobarrc_secondary &
}

function profile_adapter() {
    xmobar -p "Static {xpos = 0, ypos = 0, width = 3000, height = 52 }" /home/bernhard/.config/xmobar/xmobarrc_primary &
    xmobar -p "Static {xpos = 3000, ypos = 0, width = 5120, height = 52 }" /home/bernhard/.config/xmobar/xmobarrc_secondary &
}

function is_adapter_connected() {
    [ -n "$(xrandr | grep "^$ADAPTER_XRANDR connected")" ]
}

function is_philips_connected() {
    [ -n "$(xrandr | grep "^$PHILIPS_XRANDR connected")" ]
}

function is_dell_connected() {
    [ -n "$(xrandr | grep "^$DELL_XRANDR connected")" ]
}

killall xmobar

if is_adapter_connected; then
    echo "Switching to adapter profile..."
    profile_adapter
elif is_philips_connected; then
    if is_dell_connected; then
        echo "Switching to docked profile..."
        profile_docked
    else
        echo "Switching to philips profile..."
        profile_philips
    fi
else
    echo "Switching to laptop profile..."
    profile_laptop
fi

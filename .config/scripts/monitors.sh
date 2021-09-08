#!/bin/sh

LOG_TAG="monitors.sh"

LAPTOP_XRANDR="eDP1"
PHILIPS_XRANDR="DP1-1-8"
DELL_XRANDR="DP1-1-1"
ADAPTER_XRANDR="DP1"
DELL_DRM="card0-DP-5"

# Script started from LightDM (default false)
LIGHTDM_MODE=0

# Script started to set up session from LightDM
SESSION_SETUP=0

function profile_laptop() {
    echo "Switching to laptop profile..."
    echo "Switching to laptop profile..." | systemd-cat -t "$LOG_TAG"
    xrandr --output $LAPTOP_XRANDR --mode 3000x2000 --primary \
        --output $ADAPTER_XRANDR --off \
        --output $DELL_XRANDR --off \
        --output $PHILIPS_XRANDR --off
    xrdb -merge /home/bernhard/.config/.Xresources_laptop
}

function profile_adapter() {
    echo "Switching to adapter profile..."
    echo "Switching to adapter profile..." | systemd-cat -t "$LOG_TAG"
    xrandr --output $LAPTOP_XRANDR --mode 3000x2000 --pos 0x0 --primary \
        --output $ADAPTER_XRANDR --mode 2560x1440 --scale 2x2 --pos 3000x0 --panning 5120x2880+3000+0 \
        --output $DELL_XRANDR --off \
        --output $PHILIPS_XRANDR --off
    xrdb -merge /home/bernhard/.config/.Xresources_laptop
}

function profile_philips() {
    echo "Switching to Philips profile..."
    echo "Switching to Philips profile..." | systemd-cat -t "$LOG_TAG"
    xrandr --output $LAPTOP_XRANDR --off \
        --output $ADAPTER_XRANDR --off \
        --output $DELL_XRANDR --off \
        --output $PHILIPS_XRANDR --mode 3440x1440 --primary
    xrdb -remove
}

function profile_docked() {
    echo "Switching to docked profile..."
    echo "Switching to docked profile..." | systemd-cat -t "$LOG_TAG"
    xrandr --output $LAPTOP_XRANDR --off \
        --output $ADAPTER_XRANDR --off \
        --output $DELL_XRANDR --mode 1920x1080 --pos 0x0 \
        --output $PHILIPS_XRANDR --mode 3440x1440 --pos 1920x0 --primary
    xrdb -remove
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

function enable_dell() {
    if [ -f "/sys/class/drm/$DELL_DRM/status" ]; then
        echo on | tee /sys/class/drm/$DELL_DRM/status
    fi
}

function disable_dell() {
    if [ -f "/sys/class/drm/$DELL_DRM/status" ]; then
        echo off | tee /sys/class/drm/$DELL_DRM/status
    fi
}

echo "Hotplug event detected as $(whoami)" | systemd-cat -t "$LOG_TAG"

# Log connected monitors for debugging
xrandr | grep connected | systemd-cat -t "$LOG_TAG"

# Check if started in lightdm mode
if [ "$1" = "lightdm" ]; then
    echo "Started from lightdm" | systemd-cat -t "$LOG_TAG"
    LIGHTDM_MODE=1

    if [ "$2" = "setup" ]; then
        echo "Session setup mode" | systemd-cat -t "$LOG_TAG"
        SESSION_SETUP=1
    fi
fi

if is_adapter_connected; then
    echo "Adapter ($ADAPTER_XRANDR) connected"
    echo "Adapter ($ADAPTER_XRANDR) connected" | systemd-cat -t "$LOG_TAG"

    profile_adapter
elif is_philips_connected; then
    echo "Philips ($PHILIPS_XRANDR) connected"
    echo "Philips ($PHILIPS_XRANDR) connected" | systemd-cat -t "$LOG_TAG"

    # Enable Dell monitor manually if it hasn't been detected yet
    if ! is_dell_connected; then
        echo "Attempting to enable Dell monitor..."
        echo "Attempting to enable Dell monitor..." | systemd-cat -t "$LOG_TAG"
        enable_dell

        # Wait a second for the dell monitor to come up in xrandr
        sleep 1
    fi   

    if [ $LIGHTDM_MODE = 0 ] || [ $SESSION_SETUP = 1 ] && is_dell_connected; then
        echo "Dell ($DELL_XRANDR) connected"
        echo "Dell ($DELL_XRANDR) connected" | systemd-cat -t "$LOG_TAG"
        profile_docked
    else
        echo "Dell monitor is not used or could not be enabled (SESSION_SETUP=$SESSION_SETUP)"
        echo "Dell monitor is not used or could not be enabled (SESSION_SETUP=$SESSION_SETUP)" | systemd-cat -t "$LOG_TAG"
        profile_philips
    fi
else
    echo "No external monitors connected"
    profile_laptop
fi

if [ $LIGHTDM_MODE = 0 ] || [ $SESSION_SETUP = 1]; then
    # Restart xmonad as user bernhard
    sleep 0.1
    su -c "DISPLAY=:0 xmonad --restart" - bernhard
fi


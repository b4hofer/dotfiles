#!/usr/bin/env bash

op=$( echo -e "  Poweroff\n  HybridSleep\n  Reboot\n  Suspend\n  Lock\n  Logout" | wofi --dmenu -k /dev/null -j | awk '{print tolower($2)}' )

case $op in 
        poweroff)
                ;&
        reboot)
                ;&
        suspend)
                systemctl $op
                ;;
        hybridsleep)
                hyprlock && systemctl hybrid-sleep
                ;;
        lock)
		hyprlock
                ;;
        logout)
                hyprctl dispatch exit
                ;;
esac


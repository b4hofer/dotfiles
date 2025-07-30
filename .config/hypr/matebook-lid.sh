#!/bin/bash

LID_STATE=$1

if [[ -z "$LID_STATE" ]]; then
	LID_STATE=$(cat /proc/acpi/button/lid/LID/state | cut -d ':' -f 2 | tr -d '[:space:]')
fi

if hyprctl monitors | grep -E '\sDP-[0-9]+'; then
  if [[ "$LID_STATE" == "open" ]]; then
    hyprctl keyword monitor "desc:Japan Display Inc. 0x422A, preferred, 0x0, 1.6"
  else
    hyprctl keyword monitor "desc:Japan Display Inc. 0x422A, disable"
  fi
fi

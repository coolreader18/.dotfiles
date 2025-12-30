#!/bin/bash

declare -A apps=(
  ["Mozilla Thunderbird"]=4
)

for app in "${!apps[@]}"; do
  while ! wmctrl -r "$app" -t "${apps[$app]}"; do
    sleep 0.05
  done &
done

wait

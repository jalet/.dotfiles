#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar__top.log /tmp/polybar__bottom.log
polybar --config=$HOME/.config/polybar/config.ini top 2>&1 | tee -a /tmp/polybar__top.log & disown
polybar --config=$HOME/.config/polybar/config.ini bottom 2>&1 | tee -a /tmp/polybar__bottom.log & disown

echo "Bars launched..."

#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar example -c ~/.config/polybar/config.ini 2>&1 | tee -a /tmp/polybar1.log & disown
if type "xrandr"; then
  m=$(xrandr --query | grep " connected" | cut -d" " -f1 | grep -v 'DP-4')
  if [[ -n $m ]]; then
    MONITOR=$m polybar second -c ~/.config/polybar/config.ini &
  fi
fi
# polybar bar2 2>&1 | tee -a /tmp/polybar2.log & disown

echo "Bars launched..."

# Launch Polybar
# polybar top -c ~/.config/polybar/config.ini &

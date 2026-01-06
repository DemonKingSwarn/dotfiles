#!/bin/sh

ALARM_HOUR=$1
ALARM_MIN=$2

while :
do
  now_hour=$(date +%H)
  now_min=$(date +%M)

  if [ "$now_hour" -eq "$ALARM_HOUR" ] && [ "$now_min" -eq "$ALARM_MIN" ]; then
    notify-send "⏰ Alarm" "It's $1:$2"
    paplay /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga 2>/dev/null \
      || printf '\a'
    exit 0
  fi

  sleep 20
done

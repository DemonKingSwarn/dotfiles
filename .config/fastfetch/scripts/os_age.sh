#!/bin/bash

# Try to get filesystem creation date (works on most Linux filesystems)
install_date=$(stat -c %w /)

# If %w is "-" (meaning no birth time available), fallback to %y (change time)
if [[ "$install_date" == "-" ]]; then
    install_date=$(stat -c %y /)
fi

install_seconds=$(date -d "$install_date" +%s)
now_seconds=$(date +%s)

age_days=$(( (now_seconds - install_seconds) / 86400 ))

echo "${age_days} days"


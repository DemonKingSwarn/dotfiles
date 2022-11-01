#!/bin/bash

host=$(cat /etc/hostname)

shutdown='P'
reboot='R'
lock='L'
suspend='S'
logout='E'

rofi_cmd() {
	rofi -dmenu \
		-p "Goodbye !" \
		-theme power.rasi
}

run_rofi() {
	echo -e "$shutdown\n$reboot\n$suspend\n$lock\n$logout" | rofi_cmd
}

run_cmd() {
	if [[ $1 == '--shutdown' ]]; then
		systemctl poweroff
	elif [[ $1 == '--reboot' ]]; then
		systemctl reboot
	elif [[ $1 == '--suspend' ]]; then
		mpc -q pause
		amixer set Master mute
		systemctl suspend
	elif [[ $1 == '--logout' ]]; then
	    pkill -u $USER
    fi
}

chosen="$(run_rofi)"
case ${chosen} in
$shutdown)
	run_cmd --shutdown
	;;
$reboot)
	run_cmd --reboot
	;;
$lock)
	$HOME/.scripts/system/lock.sh
	;;
$suspend)
	run_cmd --suspend
	;;
$logout)
	run_cmd --logout
	;;
esac

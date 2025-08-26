#!/bin/sh

pkill -f /usr/libexec/polkit-gnome-authentication-agent-1
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

#/usr/lib/xdg-desktop-portal && /usr/lib/xdg-desktop-portal-hyprland &

pkill -f swaync
swaync &

pkill -f waybar
waybar &

pkill -f udiskie
udiskie &

pkill -f xwayland-satellite
xwayland-satellite &

pkill -f swww-daemon
swww-daemon &

#pkill -f nm-applet
#nm-applet &

#pkill -f copyq
#copyq --start-server &

wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &

pkill -f blueman-applet
blueman-applet &

hypr-wellbeing -d &> /dev/null &

rm ~/ly-session.log

#foot --server &

#kanata -c $HOME/.config/kanata/config.kbd &

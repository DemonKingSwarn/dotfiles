#!/bin/sh

pkill -f /usr/libexec/polkit-gnome-authentication-agent-1
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

pkill -f /usr/lib/xdg-desktop-portal
/usr/lib/xdg-desktop-portal &

pkill -f /usr/lib/xdg-desktop-portal-gnome
/usr/lib/xdg-desktop-portal-gnome &

pkill -f swaync
swaync &

pkill -f hypridle
hypridle &

pkill -f waybar
waybar &

#pkill -f auto-hide-waybar
#auto-hide-waybar &

pkill -f udiskie
udiskie &

pkill -f xwayland-satellite
xwayland-satellite &

pkill -f swww-daemon
swww-daemon &

wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &

pkill -f blueman-applet
blueman-applet &

hypr-wellbeing -d &> /dev/null &

rm ~/ly-session.log

foot --server &

#niri-float-sticky &

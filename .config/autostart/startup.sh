#!/bin/sh

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
swaync &
waybar &
udiskie &
startxwayland &
swww-daemon &
nm-applet &
copyq --start-server &
blueman-applet &
#foot --server &
#swhks &

#kanata -c $HOME/.config/kanata/config.kbd &

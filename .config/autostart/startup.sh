#!/bin/sh

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
swaync &
#waybar &
ignis init &
udiskie &
xwayland-satellite &
swww-daemon &
#nm-applet &
copyq --start-server &
#blueman-applet &
hyprwatch -d &> /dev/null &
#foot --server &

#kanata -c $HOME/.config/kanata/config.kbd &

#!/bin/bash
# syndaemon -d -i 0.8
unclutter -idle 6 &             # remove cursors after a few seconds of idleness
xset r rate 380                 # set keyboard delay

# Evoluent mouse
host=`hostname`
evoluent_mouse_device_id=`xinput -list | grep Evoluent | cut -d= -f 2 | cut -f1`
if [[ "$evoluent_mouse_device_id" != "" ]] && [[ "$host" == "scramjet" ]]; then
    xinput set-button-map $evoluent_mouse_device_id  1 3 9 4 5 6 7 8 2 10 11 12 13
    # xmodmap -e "keycode 22 = Delete"
    # xmodmap -e "keycode 119 = BackSpace"
fi

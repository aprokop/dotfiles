#!/bin/bash
# syndaemon -d -i 0.8
unclutter -idle 6 &             # remove cursors after a few seconds of idleness
xset r rate 380                 # set keyboard delay

# Evoluent mouse
host=`hostname`
if [[ "$host" == "scramjet" ]]; then
    xinput set-button-map 10  1 3 9 4 5 6 7 8 2 10 11 12 13
    # xmodmap -e "keycode 22 = Delete"
    # xmodmap -e "keycode 119 = BackSpace"
fi

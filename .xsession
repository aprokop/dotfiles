#!/bin/bash
# syndaemon -d -i 0.8
unclutter -idle 6 &             # remove cursors after a few seconds of idleness
xset r rate 380                 # set keyboard delay

# Evoluent mouse
xinput set-button-map 12  1 3 9 4 5 6 7 8 2 10 11 12 13

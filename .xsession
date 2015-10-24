#!/bin/bash
# xbindkeys
unclutter -idle 6 &             # remove cursors after a few seconds of idleness
xset r rate 380                 # set keyboard delay
# Search for 'Kingsis Peripherals  Evoluent VerticalMouse 3' in `xinput --list`
# The first number in the next line (10) is the id
# xinput set-button-map 10 1 2 3 4 5 6 7 9 8 10 11 12 13
xinput set-button-map 11 1 2 3 4 5 6 7 9 8 10 11 12 13

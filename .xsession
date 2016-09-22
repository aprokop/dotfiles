#!/bin/bash
syndaemon -d -i 0.8
unclutter -idle 6 &             # remove cursors after a few seconds of idleness
xset r rate 380                 # set keyboard delay

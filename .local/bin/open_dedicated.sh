#!/bin/bash


# Get current bspwm desktop
desktop=$(bspc query -D -d focused --names)

case $desktop in
    "I")
        firefox;;
    "II")
        alacritty;;
    "III")
        steam;;
    "IV")
        spotify;;
    *)
        alacritty;;
esac

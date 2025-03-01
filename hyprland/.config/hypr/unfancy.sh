#!/usr/bin/env sh
HYPRGAMEMODE=$(hyprctl getoption general:gaps_out | awk 'NR==1{print $3}')
if [ "$HYPRGAMEMODE" != 0 ] ; then
    hyprctl --batch "\
        #keyword animations:enabled 0;\
        #keyword decoration:shadow:enabled 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 1"
    exit
fi
hyprctl reload

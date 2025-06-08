#!/usr/bin/env bash

sinks=$(pactl list short sinks | awk '{ print $2 }')
found=0

echo "" > /tmp/it_works
for sink in $sinks
do
    if [[ $found == 1 ]]; then
        pactl set-default-sink $sink
        exit 0
    fi
    if [[ "$sink" == "$(pactl get-default-sink)" ]]; then
        found=1
    fi
done
# I don't know how to index :v
for sink in $sinks
do
    pactl set-default-sink $sink
    exit 0
done

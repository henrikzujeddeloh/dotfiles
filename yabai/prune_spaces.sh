#!/bin/sh

# Get spaces with no windows (from highest to lowest)
empty_spaces=$(yabai -m query --spaces --display | jq -r '[.[] | select(.windows | length == 0) | .index] | reverse | join(" ")')

# Destroy the empty spaces
for space in $empty_spaces; do
    yabai -m space --destroy $space 
done

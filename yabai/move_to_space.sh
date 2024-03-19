#!/bin/sh

# Get highest space index
max_space=$(yabai -m query --spaces --display | jq 'max_by(.index) | .index')
desired_space=$1
diff=$((desired_space - max_space))

# If the difference is greater than 0, create the spaces
if [ $diff -gt 0 ]; then
    for i in $(seq 1 $diff); do
        yabai -m space --create
    done
fi

# Focus the desired space
yabai -m space --focus $desired_space

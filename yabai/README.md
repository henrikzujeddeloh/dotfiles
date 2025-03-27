# Yabai and SKHD
Window manager for macOS
Configuration attempts to mimic i3.

## Requirements
Install the following using `brew`:
- yabai
- skhd
- jq

## Keybinds
All configured in `.skhdrc`.
The modifier key is `left-alt` (or `left-option` on Mac keyboards).

### Window management
- `left-alt` + vim keys: move focus to window in that direction
- `left-alt` + `shift` + vim keys: move window in that direction
- `left-alt` + `ctrl` + vim keys: squeeze window in that direction
- `left-alt` + `space`: toggle window split direction (horizontal/vertical)
- `left-alt` + `f`: toggle window fullscreen
- `left-alt` + [`1`-`9`]: move focus to space (creates spaces in between if necessary)
- `left-alt` + `shift` + [`1`-`9`]: move window to space with index
- `left-alt` + `n`: create new space (at end)
- `left-alt` + `d`: remove current space
- `left-alt` + `p`: prune empty spaces

### Application shortcuts
- `left-alt` + `t`: open terminal
- `left-alt` + `b`: open browser
- `left-alt` + `m`: open mail
- `left-alt` + `c`: open calendar

## Additional Scripts
These are some scripts to add additional functionality to yabai:
- `move_to_space.sh`: moves the focus to the desired space, creating spaces in between if necessary.
- `prune_spaces.sh`: removes empty spaces.

# Yabai and SKHD
Used for managing windows and application shortcuts on macOS.
Configuration attempts to mimic i3.

## Requirements
Install the following using `brew`:
- yabai
- skhd
- jq

## Keybinds
All configured in `.skhdrc`.
The modifier key is `alt` (or `option` on Mac keyboards).

### Window management
- `alt` + vim keys: move focus to window in that direction
- `alt` + `shift` + vim keys: move window in that direction
- `alt` + `ctrl` + vim keys: squeeze window in that direction
- `alt` + `space`: toggle window split direction (horizontal/vertical)
- `alt` + `f`: toggle window fullscreen
- `alt` + [`1`-`9`]: move focus to space (creates spaces in between if necessary)
- `alt` + `shift` + [`1`-`9`]: move window to space with index
- `alt` + `n`: create new space (at end)
- `alt` + `d`: remove current space
- `alt` + `p`: prune empty spaces

### Application shortcuts
- `alt` + `t`: open terminal
- `alt` + `b`: open browser
- `alt` + `m`: open mail
- `alt` + `c`: open calendar

## Additional Scripts
These are some scripts to add additional functionality to yabai:
- `move_to_space.sh`: moves the focus to the desired space, creating spaces in between if necessary.
- `prune_spaces.sh`: removes empty spaces.

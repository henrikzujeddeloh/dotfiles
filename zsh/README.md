# zsh
My default shell.

Custom functions are defined as individual files in the `functions` directory.
Custom aliases are defined in `aliases.zsh`.

## Requirements
Install the following **FIRST** using `brew` or `apt`:
- zsh
- oh-my-zsh (https://ohmyz.sh/#install)
- fzf
- fd (macOS)
- fdfind (Ubuntu and Debian)
- figurine (manual installation from [here](https://github.com/arsham/figurine/releases/latest))
- neovim (default editor)

## Plugins
The following plugins are installed and enabled automatically with the `install_zsh_plugins.sh`:
- zsh-autosuggestions
- zsh-syntax-highlighting

## Keybinds
These are some personal keybinds alongside default zsh and fzf keybinds:
- `ctrl` + `w`: move forward one word
- `ctrl` + `b`: move backward one word
- `ctrl` + `l`: move forward one character
- `ctrl` + `h`: move backward one character
- `ctrl` + `o`: fuzzy find files and open with neovim
- `ctrl` + `j`: accept omz-autosuggestion

# Karabiner
Key remapper for macOS

## Requirements
Install the following using `brew`:
- karabiner-elements

## Config Installation
Loading a custom configuration for karabiner is different from other dotfiles. Karabiner does not allow for symbolic links to the configuration file. Instead, this entire directory needs to be linked to the karabiner configuration directory. The install script will do this for you.
See [this](https://karabiner-elements.pqrs.org/docs/manual/misc/configuration-file-path/) for more information.

## Keybinds
All configured in `karabiner.json`.
- CAPS -> ESC (when pressed alone), CTRL (when held used with another key)
- R-CMD -> R-OPTION (on Keychron K2)
- Swap R-CMD and R-OPTION (on mac Keyboards)
- Swap L-CMD and L-OPTION (on mac Keyboards)

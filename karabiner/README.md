# Karabiner
Keyboard customizer for macOS.

## Requirements
Install the following using `brew`:
- karabiner-elements

## Config Installation
Loading a custom configuration for karabiner is different from other dotfiles. Karabiner does not allow for symbolic links to the configuration file. Instead, this entire directory needs to be linked to the karabiner configuration directory. The install script will do this for you.
See [this](https://karabiner-elements.pqrs.org/docs/manual/misc/configuration-file-path/) for more information.

## Keybinds
All configured in `karabiner.json`.
- `caps_lock` -> `escape` (when pressed alone), `control` (when held used with another key)
- `right_alt` + `aou` -> äöü (or ÄÖÜ with `shift`)
- `right_command` -> `right_option` (on Keychron K2)

# Alacritty
My default terminal emulator.

## Requirements
Install the following using `brew` or `apt`:
- alacritty
- [font](#font)

### Font
The font used is RobotoMono.

#### macOS
To install on macOS, run the following:
```sh
brew tap homebrew/cask-fonts
brew install --cask font-roboto-mono-nerd-font
```

#### Ubuntu
To install on Ubuntu, run the following:
1. Download font from [Nerd Font](https://www.nerdfonts.com/font-downloads)
2. Unzip the font
3. Move the font to `~/.fonts`
4. Update the font cache
```sh
fc-cache -f -v
```

#### Windows
To install fonts on windows, do the following:
1. Download font from [Nerd Font](https://www.nerdfonts.com/font-downloads)
2. Unzip the font
3. Select all fonts, right click and "Install"

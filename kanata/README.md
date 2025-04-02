# kanata
Keyboard layers manager

## Installation

### macOS
(Ideally run `install.sh` and everything should work)
For more information on installation see kanata GitHub release.

1. Install using `brew install kanata`.
2. Add `kanata` binary to Settings > Input Monitoring to enable permissions. (use `which kanata` to find path to binary).
3. Run `sudo katana -c $HOME/dotfiles/kanata/kanata.kbd` to test.
4. Copy `com.henrikzujeddeloh.kanata.plist` to `Library/LaunchDaemons/` and change permissions and owner (sudo chmod 644 `/Library/LaunchDaemons/com.henrikzujeddeloh.kanata.plist` and `sudo chown root:wheel /Library/LaunchDaemons/com.henrikzujeddeloh.kanata.plist`)
5. Load service using `sudo launchctl load -w Library/LaunchDaemons/com.henrikzujeddeloh.kanata.plist` (or `sudo launchctl bootstrap system Library/LauchDaemons/com.henrikzujeddeloh.kanata.plist`)
6. Enable using `sudo launchctl enable system/com.henrikzujeddeloh.kanata`.
7. Start now using `sudo launchctl start system/com.henrikzujeddeloh.kanata`

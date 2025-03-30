#!/bin/bash

# Kanata Setup Script
# This script sets up Kanata as a system-level service on macOS

# Exit on error
set -e

# Configuration variables - adjust these as needed
KANATA_PATH="/usr/local/bin/kanata"
CONFIG_PATH="$HOME/dotfiles/kanata/kanata.kbd"
SERVICE_NAME="com.henrikzujeddeloh.kanata"
LOG_DIR="/Library/Logs/Kanata"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (use sudo)"
  exit 1
fi

# Create log directory
echo "Creating log directory..."
mkdir -p "$LOG_DIR"
chmod 755 "$LOG_DIR"

# Create the plist file
echo "Creating LaunchDaemon plist..."
cat > "/Library/LaunchDaemons/$SERVICE_NAME.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>$SERVICE_NAME</string>
    <key>ProgramArguments</key>
    <array>
        <string>$KANATA_PATH</string>
        <string>-c</string>
        <string>$CONFIG_PATH</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardOutPath</key>
    <string>$LOG_DIR/kanata.out.log</string>
    <key>StandardErrorPath</key>
    <string>$LOG_DIR/kanata.err.log</string>
</dict>
</plist>
EOF

# Set proper ownership and permissions
echo "Setting permissions..."
chown root:wheel "/Library/LaunchDaemons/$SERVICE_NAME.plist"
chmod 644 "/Library/LaunchDaemons/$SERVICE_NAME.plist"

# Unload if already loaded
echo "Unloading any existing service..."
launchctl unload "/Library/LaunchDaemons/$SERVICE_NAME.plist" 2>/dev/null || true

# Load the service
echo "Loading service..."
launchctl load -w "/Library/LaunchDaemons/$SERVICE_NAME.plist"

# Check if running
echo "Checking service status..."
if launchctl list | grep -q "$SERVICE_NAME"; then
  echo "✅ Kanata service is running!"
else
  echo "⚠️ Service loaded but not running. Check logs at $LOG_DIR"
fi

echo ""
echo "Setup complete! Kanata will start automatically on boot."
echo "To check logs: cat $LOG_DIR/kanata.out.log"
echo "To restart service: sudo launchctl kickstart -k system/$SERVICE_NAME"

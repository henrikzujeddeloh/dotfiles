#!/bin/bash

echo "updating omz"
$ZSH/tools/upgrade.sh

echo "updating brew repositories"
brew update
brew doctor
brew upgrade

#!/bin/bash

# update omz
echo "updating omz"
$ZSH/tools/upgrade.sh

# update brew repos
echo "updating brew repositories"
brew update
brew doctor
brew upgrade

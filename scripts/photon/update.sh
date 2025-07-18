#!/usr/bin/env bash
#
# update photon

# update brew repos
echo "updating brew repositories"
brew update
brew doctor
brew upgrade

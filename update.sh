#!/bin/bash


read -p "would you like to update repos? " answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
    sudo apt update
    sudo apt upgrade
else
    echo "not updateing repos"
fi

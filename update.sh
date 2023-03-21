#!/bin/bash


read -p "would you like to update repos? " yn
if[ "$answer" != "${answer#[Yy]}" ] ;then
    apt update
    apt upgrade
else
    echo "not updateing repos"
fi




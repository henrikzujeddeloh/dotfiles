#!/bin/bash

LIST_OF_APPS="neofetch wireguard"

apt update
apt upgrade
apt install $LIST_OF_APPS -y


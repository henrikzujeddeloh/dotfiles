#!/bin/bash

# update apt repositories
echo "updating apt repositories"
sudo apt update
sudo apt upgrade
sudo apt autoclean
sudo apt autoremove

# update omz
echo "updating omz"
"$ZSH/tools/upgrade.sh"

# loop through active docker containers, pull new image and restart
echo "updating docker containers"
container_list="$HOME/dotfiles/scripts/proton/containers.txt"
while read -r line
do
  docker compose -f $HOME/docker/$line/docker-compose.yml pull && docker compose -f $HOME/docker/$line/docker-compose.yml up -d
done < "$container_list"

# prune unused docker images
echo "pruning docker containers"
docker image prune -a

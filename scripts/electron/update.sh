#!/usr/bin/env bash

# update apt repositories
echo "updating apt repositories"
sudo apt update
sudo apt upgrade
sudo apt autoclean
sudo apt autoremove

# loop through docker contianers, pull images and restart container
echo "updating docker containers"
container_list="$HOME/dotfiles/scripts/electron/containers.txt"
while read -r line
do
  docker compose -f $HOME/docker/$line/docker-compose.yml pull && docker compose -f $HOME/docker/$line/docker-compose.yml up -d
done < "$container_list"

# prune unused docker images
echo "pruning docker containers"
docker image prune -a

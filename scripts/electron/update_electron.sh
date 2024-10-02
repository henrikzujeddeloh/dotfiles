#!/bin/bash

echo "updating apt repositories"
sudo apt update
sudo apt upgrade
sudo apt autoclean
sudo apt autoremove


echo "updating omz"
"$ZSH/tools/upgrade.sh"


echo "updating docker containers"
container_list="$HOME/scripts/electron/containers.txt"
while read -r line
do
  docker compose -f $HOME/docker/$line/docker-compose.yml pull && docker compose -f $HOME/docker/$line/docker-compose.yml up -d
done < "$container_list"

docker image prune -a

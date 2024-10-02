#!/bin/bash

set -e

source $HOME/scripts/neutron/set_env.sh

curl -fsS --retry 5 -o /dev/null https://hc-ping.com/$PING_KEY/snapraid/start

sudo snapraid sync > $PATH_TO_BACKUP/Backup/Outputs/1_snapraid_sync.txt 2>&1
sudo snapraid -p 10 -o 10 scrub > $PATH_TO_BACKUP/Backup/Outputs/2_snapraid_scrub.txt 2>&1
sudo snapraid status > $PATH_TO_BACKUP/Backup/Outputs/3_snapraid_status.txt 2>&1 

curl -fsS --retry 5 -o /dev/null https://hc-ping.com/$PING_KEY/snapraid

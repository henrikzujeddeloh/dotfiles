#!/bin/bash

# reads input argument
device="$1"

# runs corresponding update script
if [ -z $device ]; then
    # if no argument is passed, read device name as hostname
    device=$(hostname)
fi

if [ $device = "proton" ]; then
    echo "Running proton update" 
    /bin/bash proton/update_proton.sh

elif [ $device = "electron" ]; then
    echo "Running electron update"
    /bin/bash electron/update_electron.sh

elif [ $device = "photon" ]; then
    echo "Running photon update"
    /bin/bash photon/update_photon.sh

elif [ $device = "neutron" ]; then
    echo "Running neutron update"
    /bin/bash neutron/update_neutron.sh

else
    echo $device" does not have an update script"

fi

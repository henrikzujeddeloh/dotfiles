#!/usr/bin/env bash
#
# download, extract and rename .fit files from Garmin

fit_file_location="$CLOUD/Data/Activities"
python_download_script="$HOME/projects/fit-downloader"

# download .fit files from Garmin
python3 "$python_download_script/main.py" || { echo "[ERROR] could not download .fit files"; exit 1; }

# extract .fit files from downloaded .zip
unzip "$fit_file_location"/*.zip || { echo "[ERROR] could not extract .fit files"; exit 1; }

# delete .zip files
rm "$fit_file_location"/*.zip || { echo "[ERROR] could not delete .zip files"; exit 1; }

# rename .fit files
if ! [ -x "$(command -v fit-renamer)" ]; then
    echo "[ERROR] fit-renamer is not installed. Clone fit-renamer repo, and use 'cargo install --path .'"
    exit 1
fi
find "$fit_file_location" -name "*.fit" ! -name "*_*" -exec fit-renamer {} \;

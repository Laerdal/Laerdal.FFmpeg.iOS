#!/bin/bash

json=$(curl -s https://api.github.com/repos/tanersener/mobile-ffmpeg/releases/28895129)
version=$(echo "$json" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/v//')

zip_folder_path="Laerdal.Xamarin.FFmpeg.iOS.Source"
mkdir -p $zip_folder_path
# echo "$json" | grep "browser_download_url.*-$version-ios-static-universal.zip" | cut -d : -f 2,3 | tr -d \" | wget -q --show-progress -nc -P $zip_folder_path -i -
echo "$json" | grep "browser_download_url.*-$version-ios-framework.zip" | cut -d : -f 2,3 | tr -d \" | wget -q --show-progress -nc -P $zip_folder_path -i -



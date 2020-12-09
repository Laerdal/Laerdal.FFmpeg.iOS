#!/bin/bash

repo=tanersener/mobile-ffmpeg
json=$(curl -s https://api.github.com/repos/$repo/releases/latest)
version=$(echo "$json" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/v//')

zip_folder_path="Laerdal.Xamarin.FFmpeg.iOS.Source"
mkdir -p $zip_folder_path
echo "$json" | grep "browser_download_url.*-$version-ios-xcframework.zip" | cut -d : -f 2,3 | tr -d \" | wget -q --show-progress -nc -P $zip_folder_path -i -
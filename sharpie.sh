#!/bin/bash

json=$(curl -s https://api.github.com/repos/tanersener/mobile-ffmpeg/releases/28895129)

mobile_ffmpeg_version=$(echo "$json" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/v//')
echo "mobile_ffmpeg_version = $mobile_ffmpeg_version"

mobile_ffmpeg_source_folder="Laerdal.Xamarin.FFmpeg.iOS.Source"
mobile_ffmpeg_package="min"

nuget_project_folder="Laerdal.Xamarin.FFmpeg.iOS"

frameworks_output_path="$nuget_project_folder/Frameworks"
sharpie_output_path="$nuget_project_folder/Sharpie_Generated"

rm -rf $sharpie_output_path

zip_file_name="mobile-ffmpeg-$mobile_ffmpeg_package-$mobile_ffmpeg_version-ios-framework.zip"
mkdir -p $frameworks_output_path

echo "# Extracting '$mobile_ffmpeg_source_folder/$zip_file_name' to '$frameworks_output_path'"
unzip -qq -n -d "$frameworks_output_path" "$mobile_ffmpeg_source_folder/$zip_file_name"

echo "Sharpying $frameworks_output_path/mobileffmpeg.framework"
sharpie bind -sdk iphoneos -p mobileffmpeg -o $sharpie_output_path -scope $frameworks_output_path/mobileffmpeg.framework/Headers/ -f $frameworks_output_path/mobileffmpeg.framework

# for header in $frameworks_output_path/mobileffmpeg.framework/Headers/*    .h
# do
#     echo "Sharpying $header"
#     header_filename=$(basename $header | sed -E 's/\.h$//')
# 
#     sharpie bind -p $header_filename -sdk iphoneos -o $sharpie_output_path -scope $frameworks_output_path/mobileffmpeg.framework/Headers/ $header
# done

rm -rf $frameworks_output_path
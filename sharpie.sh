#!/bin/bash

# find the latest ID here : https://api.github.com/repos/tanersener/mobile-ffmpeg/releases/latest
github_repo_owner=tanersener
github_repo=mobile-ffmpeg
github_release_id=28895129
github_info_file="$github_repo_owner.$github_repo.$github_release_id.info.json"

if [ ! -f "$github_info_file" ]; then
    echo ""
    echo "### DOWNLOAD GITHUB INFORMATION ###"
    echo ""
    github_info_file_url=https://api.github.com/repos/$github_repo_owner/$github_repo/releases/$github_release_id
    echo "Downloading $github_info_file_url to $github_info_file"
    curl -s $github_info_file_url > $github_info_file
fi

package_variant=min

echo ""
echo "### INFORMATION ###"
echo ""

# Set version
github_tag_name=`cat $github_info_file | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/v//'`
if [ -z "$github_tag_name" ]; then
    echo "Failed : Could not read Version"
    cat $github_info_file
    exit 1
fi

# Static configuration
nuget_project_folder=Laerdal.FFmpeg.iOS
package_zip_folder=Laerdal.FFmpeg.iOS.Source

# Calculated configuration
sharpie_output_path=$nuget_project_folder/Sharpie_Generated
sharpie_output_file=$sharpie_output_path/mobileffmpegApiDefinitions.cs

nuget_frameworks_folder=$nuget_project_folder/Frameworks
package_zip_file_name=mobile-ffmpeg-$package_variant-$github_tag_name-ios-framework.zip
package_zip_file=$package_zip_folder/$package_zip_file_name


# Generates variables
echo "github_repo_owner = $github_repo_owner"
echo "github_repo = $github_repo"
echo "github_release_id = $github_release_id"
echo "github_info_file = $github_info_file"
echo "github_tag_name = $github_tag_name"
echo ""
echo "package_variant = $package_variant"
echo "package_zip_folder = $package_zip_folder"
echo "package_zip_file_name = $package_zip_file_name"
echo "package_zip_file = $package_zip_file"
echo ""
echo "nuget_project_folder = $nuget_project_folder"
echo "nuget_frameworks_folder = $nuget_frameworks_folder"

echo ""
echo "### DOWNLOAD GITHUB RELEASE FILES ###"
echo ""

mkdir -p $package_zip_folder

echo "Files matching '$package_zip_file_name' :"
cat $github_info_file | grep "browser_download_url.*$package_zip_file_name" | cut -d : -f 2,3 | tr -d \"
cat $github_info_file | grep "browser_download_url.*$package_zip_file_name" | cut -d : -f 2,3 | tr -d \" | wget -q --show-progress -nc -P $package_zip_folder -i -

if [ ! -f "$package_zip_file" ]; then
    echo "Failed : Can't find '$package_zip_file'"
    exit 1
fi

echo ""
echo "### UNZIP FRAMEWORKS ###"
echo ""

rm -rf $nuget_frameworks_folder
unzip -qq -n -d "$nuget_frameworks_folder" "$package_zip_file"
echo "Frameworks :"
ls $nuget_frameworks_folder

if [ ! -d "$nuget_frameworks_folder/mobileffmpeg.framework" ]; then
    echo "Failed : Can't find '$nuget_frameworks_folder/mobileffmpeg.framework'"
    exit 1
fi

echo ""
echo "### SHARPIE ###"
echo ""

sharpie bind -sdk iphoneos -p mobileffmpeg -o $sharpie_output_path -scope $nuget_frameworks_folder/mobileffmpeg.framework/Headers/ -f $nuget_frameworks_folder/mobileffmpeg.framework

if [ -f "$sharpie_output_file" ]; then
    echo "Created :"
    echo "  - $sharpie_output_file"
    echo ""
    rm -rf $nuget_frameworks_folder
else
    echo "Failed : Can't find '$sharpie_output_file'"
    exit 1
fi
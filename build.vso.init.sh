#!/bin/bash

# GITHUB INFORMATION
github_repo_owner=tanersener
github_repo=mobile-ffmpeg
github_release_id=28895129
github_info_file="$github_repo_owner.$github_repo.$github_release_id.info.json"

if [ ! -f "$github_info_file" ]; then
    echo ""
    echo "### DOWNLOADING GITHUB INFORMATION ###"
    echo ""
    github_info_file_url=https://api.github.com/repos/$github_repo_owner/$github_repo/releases/$github_release_id
    echo "Downloading $github_info_file_url to $github_info_file"
    curl -s $github_info_file_url > $github_info_file
fi

build_revision=$(Build.BuildNumber)

# Static configuration
nuget_project_folder="Laerdal.Xamarin.FFmpeg.iOS"
nuget_project_name="Laerdal.Xamarin.FFmpeg.iOS"
package_zip_folder="Laerdal.Xamarin.FFmpeg.iOS.Source"

# Calculated configuration
nuget_frameworks_folder="$nuget_project_folder/Frameworks"
nuget_output_folder="$nuget_project_name.Output"
nuget_csproj_path="$nuget_project_folder/$nuget_project_name.csproj"
github_tag_name=`cat $github_info_file | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/v//'`
github_short_version=`echo "$github_tag_name" | sed 's/.LTS//'`
build_version=$github_short_version.$build_revision

# Generates variables
echo "##vso[build.updatebuildnumber]$build_version"
echo "##vso[task.setvariable variable=github.repo_owner]$github_repo_owner"
echo "##vso[task.setvariable variable=github.repo]$github_repo"
echo "##vso[task.setvariable variable=github.release_id]$github_release_id"
echo "##vso[task.setvariable variable=github.info_file]$github_info_file"
echo "##vso[task.setvariable variable=github.tag_name]$github_tag_name"
echo "##vso[task.setvariable variable=github.short_version]$github_short_version"
echo "##vso[task.setvariable variable=package.zip_folder]$package_zip_folder"
echo "##vso[task.setvariable variable=nuget.project_folder]$nuget_project_folder"
echo "##vso[task.setvariable variable=nuget.output_folder]$nuget_output_folder"
echo "##vso[task.setvariable variable=nuget.project_name]$nuget_project_name"
echo "##vso[task.setvariable variable=nuget.frameworks_folder]$nuget_frameworks_folder"
echo "##vso[task.setvariable variable=nuget.csproj_path]$nuget_csproj_path"

echo ""
echo "### DOWNLOAD ALL GITHUB RELEASE FILES ###"
echo ""

mkdir -p $package_zip_folder
package_zip_file_name_pattern="mobile-ffmpeg-.*-$github_tag_name-ios-framework.zip"
echo "Files matching '$package_zip_file_name_pattern' :"
cat $github_info_file | grep "browser_download_url.*$package_zip_file_name_pattern" | cut -d : -f 2,3 | tr -d \"
cat $github_info_file | grep "browser_download_url.*$package_zip_file_name_pattern" | cut -d : -f 2,3 | tr -d \" | wget -q -nc -P $package_zip_folder -i -

rm -rf $nuget_project_folder/bin
rm -rf $nuget_project_folder/obj

echo ""
echo "### READY ###"
echo ""
echo "Pipeline variables available from this point on :"
echo ""
echo "- \$(Build.BuildNumber) = $build_version"
echo ""
echo "- \$(github.info_file) = $github_info_file"
echo "- \$(github.repo_owner) = $github_repo_owner"
echo "- \$(github.repo) = $github_repo"
echo "- \$(github.release_id) = $github_release_id"
echo "- \$(github.tag_name) = $github_tag_name"
echo "- \$(github.short_version) = $github_short_version"
echo ""
echo "- \$(package.zip_folder) = $package_zip_folder"
echo ""
echo "- \$(nuget.project_folder) = $nuget_project_folder"
echo "- \$(nuget.output_folder) = $nuget_output_folder"
echo "- \$(nuget.project_name) = $nuget_project_name"
echo "- \$(nuget.frameworks_folder) = $nuget_frameworks_folder"
echo "- \$(nuget.csproj_path) = $nuget_csproj_path"
echo ""

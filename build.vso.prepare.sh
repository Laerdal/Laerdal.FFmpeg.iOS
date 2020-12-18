#!/bin/bash

package_variant=

build_version=$(Build.BuildNumber)

github_tag_name=$(github.tag_name)
github_info_file=$(github.info_file)

package_zip_folder=$(package.zip_folder)

nuget_project_folder=$(nuget.project_folder)
nuget_project_name=$(nuget.project_name)
nuget_output_folder=$(nuget.output_folder)
nuget_frameworks_folder=$(nuget.frameworks_folder)


# Required variables
[ -z "$build_version" ] && exit 1

[ -z "$github_tag_name" ] && exit 1
[ -z "$github_info_file" ] && exit 1

[ -z "$package_zip_folder" ] && exit 1

[ -z "$nuget_project_folder" ] && exit 1
[ -z "$nuget_project_name" ] && exit 1
[ -z "$nuget_output_folder" ] && exit 1
[ -z "$nuget_frameworks_folder" ] && exit 1

# see https://github.com/tanersener/mobile-ffmpeg for more information
package_libraries="?"
[ "$package_variant" = "audio" ] && package_libraries="lame libilbc libvorbis opencore-amr opus shine soxr speex twolame vo-amrwbenc wavpack"
[ "$package_variant" = "full" ] && package_libraries="fontconfig freetype fribidi gmp gnutls kvazaar lame libaom libass libiconv libilbc libtheora libvorbis libvpx libwebp libxml2 opencore-amr opus shine snappy soxr speex twolame vo-amrwbenc wavpack"
[ "$package_variant" = "full-gpl" ] && package_libraries="fontconfig freetype fribidi gmp gnutls kvazaar lame libaom libass libiconv libilbc libtheora libvorbis libvpx libwebp libxml2 opencore-amr opus shine snappy soxr speex twolame vid.stab vo-amrwbenc wavpack x264 x265 xvidcore"
[ "$package_variant" = "https" ] && package_libraries="gmp gnutls"
[ "$package_variant" = "https-gpl" ] && package_libraries="gmp gnutls vid.stab x264 x265 xvidcore"
[ "$package_variant" = "min" ] && package_libraries="-"
[ "$package_variant" = "min-gpl" ] && package_libraries="vid.stab x264 x265 xvidcore"
[ "$package_variant" = "video" ] && package_libraries="fontconfig freetype fribidi kvazaar libaom libass libiconv libtheora libvpx libwebp snappy"

nuget_variant="$package_variant"
[ "$package_variant" = "audio" ] && nuget_variant="Audio"
[ "$package_variant" = "full" ] && nuget_variant="Full"
[ "$package_variant" = "full-gpl" ] && nuget_variant="Full.Gpl"
[ "$package_variant" = "https" ] && nuget_variant="Https"
[ "$package_variant" = "https-gpl" ] && nuget_variant="Https.Gpl"
[ "$package_variant" = "min" ] && nuget_variant="Min"
[ "$package_variant" = "min-gpl" ] && nuget_variant="Min.Gpl"
[ "$package_variant" = "video" ] && nuget_variant="Video"

package_zip_file_name="mobile-ffmpeg-$package_variant-$github_tag_name-ios-framework.zip"
package_zip_file="$package_zip_folder/$package_zip_file_name"
nuget_filename="$nuget_project_name.$nuget_variant.$build_version.nupkg"
nuget_output_file="$nuget_output_folder/$nuget_filename"

echo "##vso[task.setvariable variable=package.variant]$package_variant"
echo "##vso[task.setvariable variable=package.libraries]$package_libraries"
echo "##vso[task.setvariable variable=package.zip_file_name]$package_zip_file_name"
echo "##vso[task.setvariable variable=package.zip_file]$package_zip_file"
echo "##vso[task.setvariable variable=nuget.variant]$nuget_variant"
echo "##vso[task.setvariable variable=nuget.filename]$nuget_filename"
echo "##vso[task.setvariable variable=nuget.filepath]$nuget_output_file"

echo ""
echo "### DOWNLOAD GITHUB RELEASE FILES ###"
echo ""

mkdir -p $package_zip_folder

echo "Files matching '$package_zip_file_name' :"
cat $github_info_file | grep "browser_download_url.*$package_zip_file_name" | cut -d : -f 2,3 | tr -d \"
cat $github_info_file | grep "browser_download_url.*$package_zip_file_name" | cut -d : -f 2,3 | tr -d \" | wget -q --show-progress -nc -P $package_zip_folder -i -

if [ ! -f "$package_zip_file" ]; then
    echo "Failed"
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
    echo "Failed"
    exit 1
fi

rm -rf $nuget_project_folder/bin
rm -rf $nuget_project_folder/obj

echo ""
echo "### READY ###"
echo ""
echo "Run MSBuild task with parameters :  -t:Rebuild -restore:True -p:Configuration=Release -p:NugetPackageVariantName=\$(nuget.variant) -p:PackageVersion=\$(Build.BuildNumber) -p:ExternalLibraries=\"\$(package.libraries)\""
echo ""
echo "Pipeline variables available from this point on :"
echo ""
echo "- \$(package.variant) = $package_variant"
echo "- \$(package.libraries) = $package_libraries"
echo "- \$(package.zip_file_name) = $package_zip_file_name"
echo "- \$(package.zip_file) = $package_zip_file"
echo ""
echo "- \$(nuget.variant) = $nuget_variant"
echo "- \$(nuget.filename) = $nuget_filename"
echo "- \$(nuget.filepath) = $nuget_output_file"
echo ""
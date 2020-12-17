#!/bin/bash

echo ""
json=$(curl -s https://api.github.com/repos/tanersener/mobile-ffmpeg/releases/28895129)

mobile_ffmpeg_version=$(echo "$json" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/v//')
echo "mobile_ffmpeg_version = $mobile_ffmpeg_version"
clean_mobile_ffmpeg_version=$(echo "$mobile_ffmpeg_version" | sed 's/.LTS//')
echo "clean_mobile_ffmpeg_version = $clean_mobile_ffmpeg_version"

date=$(date +%m%d)
time=$(date +%H%M%S)

version="$clean_mobile_ffmpeg_version.$date.$time"
echo "version = $version"

mobile_ffmpeg_source_folder="Laerdal.Xamarin.FFmpeg.iOS.Source"

nuget_project_folder="Laerdal.Xamarin.FFmpeg.iOS"
nuget_project_csproj="$nuget_project_folder/Laerdal.Xamarin.FFmpeg.iOS.csproj"
nuget_output_folder="$nuget_project_folder.Output"

universal_output_path="$nuget_project_folder/Universal"
frameworks_output_path="$nuget_project_folder/Frameworks"

build_package()
{
    echo ""
    rm -rf "$nuget_project_folder/bin"
    rm -rf "$nuget_project_folder/obj"
    mobile_ffmpeg_package=$1
    nuget_package_variant_name=$2
    external_libraries=$3

    output_file="$nuget_output_folder/$nuget_project_folder.$nuget_package_variant_name.$version.nupkg"


    # 1) Unzip framework files
    zip_file_name="mobile-ffmpeg-$mobile_ffmpeg_package-$mobile_ffmpeg_version-ios-framework.zip"
    mkdir -p $frameworks_output_path

    echo "# Extracting '$mobile_ffmpeg_source_folder/$zip_file_name' to '$frameworks_output_path'"
    unzip -qq -n -d "$frameworks_output_path" "$mobile_ffmpeg_source_folder/$zip_file_name"

    ls $frameworks_output_path

    # 1) Unzip static-universal files
    # zip_file_name="mobile-ffmpeg-$mobile_ffmpeg_package-$mobile_ffmpeg_version-ios-static-universal.zip"
    # mkdir -p $universal_output_path

    # echo "# Extracting '$mobile_ffmpeg_source_folder/$zip_file_name' to '$universal_output_path'"
    # unzip -qq -n -d "$universal_output_path" "$mobile_ffmpeg_source_folder/$zip_file_name"

    # 3) Build Nuget
    echo "# Building '$output_file'"
    #-noLogo -verbosity:minimal
    msbuild $nuget_project_csproj -t:Rebuild -restore:True -p:Configuration=Release -p:NugetPackageVariantName=$nuget_package_variant_name -p:PackageVersion=$version -p:ExternalLibraries="$external_libraries"

    # 4) Cleaning
    rm -rf $frameworks_output_path
    # rm -rf $universal_output_path
}

# see https://github.com/tanersener/mobile-ffmpeg for more information
time build_package audio Audio "lame libilbc libvorbis opencore-amr opus shine soxr speex twolame vo-amrwbenc wavpack"
time build_package full Full "fontconfig freetype fribidi gmp gnutls kvazaar lame libaom libass libiconv libilbc libtheora libvorbis libvpx libwebp libxml2 opencore-amr opus shine snappy soxr speex twolame vo-amrwbenc wavpack"
time build_package full-gpl Full.Gpl "fontconfig freetype fribidi gmp gnutls kvazaar lame libaom libass libiconv libilbc libtheora libvorbis libvpx libwebp libxml2 opencore-amr opus shine snappy soxr speex twolame vid.stab vo-amrwbenc wavpack x264 x265 xvidcore"
time build_package https Https "gmp gnutls"
time build_package https-gpl Https.Gpl "gmp gnutls vid.stab x264 x265 xvidcore"
time build_package min Min "-"
time build_package min-gpl Min.Gpl "vid.stab x264 x265 xvidcore"
time build_package video Video "fontconfig freetype fribidi kvazaar libaom libass libiconv libtheora libvpx libwebp snappy"
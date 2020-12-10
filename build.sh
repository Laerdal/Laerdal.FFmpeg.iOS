#!/bin/bash

repo=tanersener/mobile-ffmpeg
json=$(curl -s https://api.github.com/repos/$repo/releases/latest)

mobile_ffmpeg_version=$(echo "$json" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/v//')
version="$mobile_ffmpeg_version.0"

mobile_ffmpeg_source_folder="Laerdal.Xamarin.FFmpeg.iOS.Source"

nuget_project_folder="Laerdal.Xamarin.FFmpeg.iOS"
nuget_project_csproj="$nuget_project_folder/Laerdal.Xamarin.FFmpeg.iOS.csproj"
nuget_output_folder="$nuget_project_folder.Output"

xcframeworks_output_path="$nuget_project_folder/XCFrameworks"
frameworks_output_path="$nuget_project_folder/Frameworks"
sharpie_output_path="$nuget_project_folder/Sharpie_Generated"

build_package()
{
    mobile_ffmpeg_package=$1
    nuget_package_variant_name=$2

    output_file="$nuget_output_folder/$nuget_project_folder.$nuget_package_variant_name.$version.nupkg"

    if [ -f "$output_file" ]; then
        echo "# '$output_file' already exists. Not building"
    else
        echo "# Building '$output_file'"

        # 1) Unzip XCFrameworks
        echo "# 1) Unzip XCFrameworks"
        zip_file_name="mobile-ffmpeg-$mobile_ffmpeg_package-$mobile_ffmpeg_version-ios-xcframework.zip"

        mkdir -p $xcframeworks_output_path

        echo "# Extracting '$mobile_ffmpeg_source_folder/$zip_file_name' to '$xcframeworks_output_path'"
        unzip -qq -n -d "$xcframeworks_output_path" "$mobile_ffmpeg_source_folder/$zip_file_name"

        # 2) Build Fat Libraries/Frameworks
        echo "# 2) Build Fat Libraries/Frameworks"
        mkdir -p $frameworks_output_path
        for xcframework in $xcframeworks_output_path/*.xcframework
        do
            framework_name=$(basename $xcframework | sed -E 's/\.xcframework$//')

            cp -a "$xcframework/ios-arm64/." "$frameworks_output_path/"

            output_framework_path="$frameworks_output_path/$framework_name.framework/$framework_name"

            rm "$output_framework_path"

            lipo_iphoneos="$xcframework/ios-arm64/$framework_name.framework/$framework_name"
            #lipo -info "$lipo_iphoneos"
            lipo_iphonesimulator="$xcframework/ios-x86_64-simulator/$framework_name.framework/$framework_name"
            #lipo -info "$lipo_iphonesimulator" 

            echo "# Building Fat framework for $framework_name in package $mobile_ffmpeg_package"
            lipo -create -output "$output_framework_path" "$lipo_iphoneos" "$lipo_iphonesimulator"
            #lipo -info "$output_framework_path"
        done

        # 3) Build Nuget
        echo "# 3) Build Nuget"
        msbuild $nuget_project_csproj -t:Rebuild -restore:True -p:Configuration=Release -p:NugetPackageVariantName=$nuget_package_variant_name -p:PackageVersion=$version

        # 4) Cleaning
        echo "# 4) Cleaning"
        rm -rf $xcframeworks_output_path
        rm -rf $frameworks_output_path
    fi
}

generate_sharpie_files()
{
    ffmpeg_package="min"

    # 1) Cleaning previous sharpie files
    echo "# 1) Cleaning previous sharpie files"
    rm -rf $sharpie_output_path

    # 2) Unzip XCFrameworks for $ffmpeg_package
    echo "# 2) Unzip XCFrameworks for $ffmpeg_package"
    zip_file_name="mobile-ffmpeg-$ffmpeg_package-$mobile_ffmpeg_version-ios-xcframework.zip"

    mkdir -p $xcframeworks_output_path

    echo "# Extracting '$mobile_ffmpeg_source_folder/$zip_file_name' to '$xcframeworks_output_path'"
    unzip -qq -n -d "$xcframeworks_output_path" "$mobile_ffmpeg_source_folder/$zip_file_name"

    # 3) Build Fat Libraries/Frameworks for $ffmpeg_package
    echo "# 3) Build Fat Libraries/Frameworks for $ffmpeg_package"
    mkdir -p $frameworks_output_path
    for xcframework in $xcframeworks_output_path/*.xcframework
    do
        framework_name=$(basename $xcframework | sed -E 's/\.xcframework$//')

        cp -a "$xcframework/ios-arm64/." "$frameworks_output_path/"

        output_framework_path="$frameworks_output_path/$framework_name.framework/$framework_name"

        rm "$output_framework_path"

        lipo_iphoneos="$xcframework/ios-arm64/$framework_name.framework/$framework_name"
        #lipo -info "$lipo_iphoneos"
        lipo_iphonesimulator="$xcframework/ios-x86_64-simulator/$framework_name.framework/$framework_name"
        #lipo -info "$lipo_iphonesimulator" 

        echo "# Building Fat framework for $framework_name in package $ffmpeg_package"
        lipo -create -output "$output_framework_path" "$lipo_iphoneos" "$lipo_iphonesimulator"
        #lipo -info "$output_framework_path"
    done

    # 4) Process headers
    echo "# 4) Process headers"
    for header_file_name in $@
    do
        framework_name="mobileffmpeg"

        header_folder_path="$frameworks_output_path/mobileffmpeg.framework/Headers"
        header_file_path="$header_folder_path/$header_file_name.h"

        output_file_prefix="$header_file_name"

        namespace="$nuget_project_folder"

        echo "Sharpying $header_file_path into $sharpie_output_path/$output_file_prefix"

        mkdir -p $sharpie_output_path
        sharpie bind -n $namespace -p $output_file_prefix -sdk iphoneos -o $sharpie_output_path -scope $header_folder_path/ $header_file_path
    done

    # 5) Cleaning
    echo "# 5) Cleaning"
    rm -rf $xcframeworks_output_path
    rm -rf $frameworks_output_path
}


# see https://github.com/tanersener/mobile-ffmpeg for more information
time build_package audio Audio
time build_package full Full
time build_package full-gpl Full.Gpl
time build_package https Https
time build_package https-gpl Https.Gpl
time build_package min Min
time build_package min-gpl Min.Gpl
time build_package video Video

time generate_sharpie_files AtomicLong ExecuteDelegate LogDelegate MediaInformation MediaInformationParser MobileFFmpeg MobileFFmpegConfig MobileFFprobe Statistics StatisticsDelegate StreamInformation FFmpegExecution
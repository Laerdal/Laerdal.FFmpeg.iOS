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

# VARIABLES
usage(){
    echo "### Wrong parameters ###"
    echo "usage: ./build.local.sh [-p|--package [audio|full|full-gpl|https|https-gpl|min|min-gpl|video]] [-r|--revision build_revision]"
    echo "see https://github.com/tanersener/mobile-ffmpeg for more information about the --package parameter"
}

package_variant=
build_revision=`date +%m%d.%H%M%S`

while [ "$1" != "" ]; do
    case $1 in
        -p | --package )        shift
                                package_variant=$1
                                ;;
        -r | --revision )       shift
                                build_revision=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

# Required variables
if [ -z "$package_variant" ]; then
    usage
    exit 1
fi

echo ""
echo "### INFORMATION ###"
echo ""

# Set version
github_tag_name=`cat $github_info_file | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/v//'`
github_short_version=`echo "$github_tag_name" | sed 's/.LTS//'`
build_version=$github_short_version.$build_revision
echo "##vso[build.updatebuildnumber]$build_version"
if [ -z "$github_short_version" ]; then
    echo "Failed : Could not read Version"
    cat $github_info_file
    exit 1
fi

# Static configuration
nuget_project_folder="Laerdal.Xamarin.FFmpeg.iOS"
nuget_project_name="Laerdal.Xamarin.FFmpeg.iOS"
package_zip_folder="Laerdal.Xamarin.FFmpeg.iOS.Source"

# Calculated configuration
nuget_frameworks_folder="$nuget_project_folder/Frameworks"
nuget_output_folder="$nuget_project_name.Output"
nuget_csproj_path="$nuget_project_folder/$nuget_project_name.csproj"

package_zip_file_name="mobile-ffmpeg-$package_variant-$github_tag_name-ios-framework.zip"
package_zip_file="$package_zip_folder/$package_zip_file_name"


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

nuget_filename="$nuget_project_name.$nuget_variant.$build_version.nupkg"
nuget_output_file="$nuget_output_folder/$nuget_filename"

# Generates variables
echo "build_version = $build_version"
echo ""
echo "github_repo_owner = $github_repo_owner"
echo "github_repo = $github_repo"
echo "github_release_id = $github_release_id"
echo "github_info_file = $github_info_file"
echo "github_tag_name = $github_tag_name"
echo "github_short_version = $github_short_version"
echo ""
echo "package_variant = $package_variant"
echo "package_libraries = $package_libraries"
echo "package_zip_folder = $package_zip_folder"
echo "package_zip_file_name = $package_zip_file_name"
echo "package_zip_file = $package_zip_file"
echo ""
echo "nuget_variant = $nuget_variant"
echo "nuget_project_folder = $nuget_project_folder"
echo "nuget_output_folder = $nuget_output_folder"
echo "nuget_project_name = $nuget_project_name"
echo "nuget_frameworks_folder = $nuget_frameworks_folder"
echo "nuget_csproj_path = $nuget_csproj_path"
echo "nuget_filename = $nuget_filename"

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

echo ""
echo "### MSBUILD ###"
echo ""

rm -rf $nuget_project_folder/bin
rm -rf $nuget_project_folder/obj
msbuild $nuget_csproj_path -t:Rebuild -restore:True -p:Configuration=Release -p:NugetPackageVariantName=$nuget_variant -p:PackageVersion=$build_version -p:ExternalLibraries="$package_libraries"


if [ -f "$nuget_output_file" ]; then
    echo ""
    echo "### SUCCESS ###"
    echo ""

    # Cleaning
    rm -rf $nuget_frameworks_folder

else
    echo ""
    echo "### FAILED ###"
    echo ""
    exit 1
fi
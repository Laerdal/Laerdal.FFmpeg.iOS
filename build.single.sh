#!/bin/bash

usage(){
    echo "usage: ./build.single.sh [-p|--package [audio|full|full-gpl|https|https-gpl|min|min-gpl|video]] [-r|--revision build_revision] [-c|--clean-output] [-v|--verbose] [-s|--sharpie] [-o|--output path]"
    echo "parameters:"
    echo "  -p | --package [audio|full|full-gpl|https|https-gpl|min|min-gpl|video]    REQUIRED, See https://github.com/tanersener/mobile-ffmpeg for more information"
    echo "  -r | --revision [build_revision]                                          Sets the revision number, default = mdd.hMMSS"
    echo "  -c | --clean-output                                                       Cleans the output before building"
    echo "  -v | --verbose                                                            Enable verbose build details from msbuild tasks"
    echo "  -s | --sharpie                                                            Regenerates objective sharpie autogenerated files, useful to spot API changes"
    echo "  -h | --help                                                               Prints this message"
    echo
}

while [ "$1" != "" ]; do
    case $1 in
        -p | --package )        shift
                                package_variant=$1
                                ;;
        -c | --clean-output )   clean_output=1
                                ;;
        -r | --revision )       shift
                                build_revision=$1
                                ;;
        -v | --verbose )        verbose=1
                                ;;
        -s | --sharpie )        sharpie=1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     echo
                                echo "### Wrong parameter: $1 ###"
                                echo
                                usage
                                exit 1
    esac
    shift
done

# Required variables
if [ -z "$package_variant" ]; then
    usage
    exit 1
fi

if [ -z "$build_revision" ]; then
    build_revision=`date +%-m%d.%-H%M%S`
fi

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

# Static configuration
nuget_project_folder="Laerdal.Xamarin.FFmpeg.iOS"
nuget_project_name="Laerdal.Xamarin.FFmpeg.iOS"
nuget_output_folder="$nuget_project_name.Output"
nuget_csproj_path="$nuget_project_folder/$nuget_project_name.csproj"
nuget_filename="$nuget_project_name.$nuget_variant.$build_version.nupkg"
nuget_output_file="$nuget_output_folder/$nuget_variant/$nuget_filename"

nuget_frameworks_folder="$nuget_project_folder/Frameworks"

package_zip_folder="$nuget_project_name.Source"
package_zip_file_name="mobile-ffmpeg-$package_variant-$github_tag_name-ios-framework.zip"
package_zip_file="$package_zip_folder/$package_zip_file_name"

if [ "$sharpie" = "1" ]; then
    sharpie_version=`sharpie -v`
    sharpie_output_path=$nuget_project_folder/Sharpie_Generated
    sharpie_output_file=$sharpie_output_path/ApiDefinitions.cs
fi

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
echo "nuget_output_file = $nuget_output_file"

if [ "$sharpie" = "1" ]; then
    echo
    echo "sharpie_version = $sharpie_version"
    echo "sharpie_output_path = $sharpie_output_path"
    echo "sharpie_output_file = $sharpie_output_file"
fi

if [ "$clean_output" = "1" ]; then
    echo
    echo "### CLEAN OUTPUT ###"
    echo
    rm -rf $nuget_output_folder/$nuget_variant
    echo "Deleted : $nuget_output_folder/$nuget_variant"
fi

echo ""
echo "### DOWNLOAD GITHUB RELEASE FILES ###"
echo ""

mkdir -p $package_zip_folder

echo "Files matching '$package_zip_file_name' :"
cat $github_info_file | grep "browser_download_url.*$package_zip_file_name" | cut -d : -f 2,3 | tr -d \"

wget_parameters="${wget_parameters} -q" # Quiet
if [ "$verbose" = "1" ]; then
    wget_parameters="${wget_parameters} --show-progress" # Force wget to display the progress bar.
fi
wget_parameters="${wget_parameters} -nc" # --no-clobber = keep existing file
wget_parameters="${wget_parameters} -P $package_zip_folder" #--directory-prefix = Output directory
wget_parameters="${wget_parameters} -i -" # Input (If you specify ‘-’ as file name, the URLs will be read from standard input.)

echo ""
echo "wget_parameters = $wget_parameters"
cat $github_info_file | grep "browser_download_url.*$package_zip_file_name" | cut -d : -f 2,3 | tr -d \" | wget $wget_parameters

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

if [ "$sharpie" = "1" ]; then
    echo
    echo "### SHARPIE ###"
    echo

    sharpie bind -sdk iphoneos -o $sharpie_output_path -n $nuget_project_name -f $nuget_frameworks_folder/mobileffmpeg.framework
fi

echo ""
echo "### MSBUILD ###"
echo ""

msbuild_parameters=""
if [ ! "$verbose" = "1" ]; then
    msbuild_parameters="${msbuild_parameters} -nologo -verbosity:quiet"
fi
msbuild_parameters="${msbuild_parameters} -t:Rebuild"
msbuild_parameters="${msbuild_parameters} -restore:True"
msbuild_parameters="${msbuild_parameters} -p:Configuration=Release"
msbuild_parameters="${msbuild_parameters} -p:PackageVersion=$build_version"
msbuild_parameters="${msbuild_parameters} -p:NugetPackageVariantName=$nuget_variant"
msbuild_parameters="${msbuild_parameters} -p:ExternalLibraries=\"$package_libraries\""
echo "msbuild_parameters = $msbuild_parameters"
echo ""

rm -rf $nuget_project_folder/bin
rm -rf $nuget_project_folder/obj
msbuild $nuget_csproj_path $msbuild_parameters

if [ -f "$nuget_output_file" ]; then
    echo "Created :"
    echo "  - $nuget_output_file"
    echo ""
    # rm -rf $nuget_frameworks_folder
else
    echo "Failed : Can't find '$nuget_output_file'"
    exit 1
fi
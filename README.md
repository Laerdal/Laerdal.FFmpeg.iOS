# Laerdal.Xamarin.FFmpeg.iOS

Xamarin binding library around @tanersener's Mobile-FFmpeg library. The native iOS library is located here: https://github.com/tanersener/mobile-ffmpeg

Mobile FFmpeg Package | Laerdal.Xamarin.FFmpeg.iOS | Laerdal.Xamarin.FFmpeg.Android |
|     :----    |     :----:    |     :----:    |
Audio | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.iOS.Audio)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.iOS.Audio/) | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.Android.Audio)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.Android.Audio/) |
Full | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.iOS.Full)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.iOS.Full/) | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.Android.Full)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.Android.Full/) |
Full.Gpl | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.iOS.Full.Gpl)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.iOS.Full.Gpl/) | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.Android.Full.Gpl)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.Android.Full.Gpl/) |
Https | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.iOS.Https)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.iOS.Https/) | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.Android.Https)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.Android.Https/) |
Https.Gpl | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.iOS.Https.Gpl)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.iOS.Https.Gpl/) | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.Android.Https.Gpl)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.Android.Https.Gpl/) |
Min | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.iOS.Min)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.iOS.Min/) | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.Android.Min)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.Android.Min/) |
Min.Gpl | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.iOS.Min.Gpl)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.iOS.Min.Gpl/) | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.Android.Min.Gpl)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.Android.Min.Gpl/) |
Video | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.iOS.Video)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.iOS.Video/) | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.Android.Video)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.Android.Video/) |

## External libraries

Mobile FFmpeg Package | External libraries |
|     :----    | :----: |
Audio | lame libilbc libvorbis opencore-amr opus shine soxr speex twolame vo-amrwbenc wavpack |
Full | fontconfig freetype fribidi gmp gnutls kvazaar lame libaom libass libiconv libilbc libtheora libvorbis libvpx libwebp libxml2 opencore-amr opus shine snappy soxr speex twolame vo-amrwbenc wavpack |
Full.Gpl | fontconfig freetype fribidi gmp gnutls kvazaar lame libaom libass libiconv libilbc libtheora libvorbis libvpx libwebp libxml2 opencore-amr opus shine snappy soxr speex twolame vid.stab vo-amrwbenc wavpack x264 x265 xvidcore |
Https | gmp gnutls |
Https.Gpl | gmp gnutls vid.stab x264 x265 xvidcore |
Min | - |
Min.Gpl | vid.stab x264 x265 xvidcore |
Video | fontconfig freetype fribidi kvazaar libaom libass libiconv libtheora libvpx libwebp snappy |

## Folder structure

- Laerdal.Xamarin.FFmpeg.iOS = Xamarin ObjectiveC Binding Library project and nuget files
- Laerdal.Xamarin.FFmpeg.iOS.Output = Build output from building *Laerdal.Xamarin.FFmpeg.iOS*

## Local build

### Requirements

You'll need :

- **MacOS**
  - with **XCode**
  - with **Xamarin.iOS** (obviously)
  - [with **ObjectiveSharpie**] :

```bash
brew cask install objectivesharpie
```

[More about Objective Sharpie](https://docs.microsoft.com/en-us/xamarin/cross-platform/macios/binding/objective-sharpie/get-started)

### Steps to build

#### 1) Checkout

```bash
git clone https://github.com/Laerdal/Laerdal.Xamarin.Dfu.iOS.git
```

#### 2) Download latest Release from [tanersener/mobile-ffmpeg](https://github.com/tanersener/mobile-ffmpeg/releases)

```bash
./download.sh
```

#### 3) Build all Nuget packages

```bash
./build.sh
```

#### 4) Review changes in Laerdal.Xamarin.FFmpeg.iOS/Sharpie_Generated

The `./build.sh` script runs the objective sharpie command. You need to review if any API changes have occured in Laerdal.Xamarin.FFmpeg.iOS/Sharpie_Generated.

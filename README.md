# Laerdal.Xamarin.FFmpeg.iOS

Xamarin binding library around @tanersener's Mobile-FFmpeg library. The native iOS library is located here: https://github.com/tanersener/mobile-ffmpeg

| Laerdal.Xamarin.FFmpeg.iOS | Laerdal.Xamarin.FFmpeg.Android |
|     :----:    |     :----:    |
| [![Build status](https://dev.azure.com/LaerdalMedical/Healthcare%20Responders/_apis/build/status/Libraries/OpenSource/Laerdal.Xamarin.FFmpeg.iOS)](https://dev.azure.com/LaerdalMedical/Healthcare%20Responders/_build/latest?definitionId=102) | [![Build status](https://dev.azure.com/LaerdalMedical/Healthcare%20Responders/_apis/build/status/Libraries/OpenSource/Laerdal.Xamarin.FFmpeg.Android)](https://dev.azure.com/LaerdalMedical/Healthcare%20Responders/_build/latest?definitionId=101) |
| [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.iOS.Full)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.iOS.Full/) | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.Android.Full)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.Android.Full/) |
| [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.iOS.Full.Gpl)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.iOS.Full.Gpl/) | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.Android.Full.Gpl)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.Android.Full.Gpl/) |
| [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.iOS.Https)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.iOS.Https/) | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.Android.Https)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.Android.Https/) |
| [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.iOS.Https.Gpl)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.iOS.Https.Gpl/) | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.Android.Https.Gpl)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.Android.Https.Gpl/) |
| [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.iOS.Min)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.iOS.Min/) | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.Android.Min)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.Android.Min/) |
| [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.iOS.Min.Gpl)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.iOS.Min.Gpl/) | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.Android.Min.Gpl)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.Android.Min.Gpl/) |
| [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.iOS.Video)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.iOS.Video/) | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.Android.Video)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.Android.Video/) |

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

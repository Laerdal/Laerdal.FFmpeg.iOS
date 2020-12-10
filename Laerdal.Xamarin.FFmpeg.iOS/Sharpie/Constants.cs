using System;
using ObjCRuntime;
using Foundation;
using CoreFoundation;
using UIKit;

namespace Laerdal.Xamarin.FFmpeg.iOS
{

	[Static]
	partial interface Constants
	{
		// extern NSString *const MOBILE_FFMPEG_VERSION;
		[Field ("MOBILE_FFMPEG_VERSION", "__Internal")]
		NSString MOBILE_FFMPEG_VERSION { get; }
        
		// extern const int RETURN_CODE_SUCCESS;
		[Field ("RETURN_CODE_SUCCESS", "__Internal")]
		int RETURN_CODE_SUCCESS { get; }

		// extern const int RETURN_CODE_CANCEL;
		[Field ("RETURN_CODE_CANCEL", "__Internal")]
		int RETURN_CODE_CANCEL { get; }

		// extern NSString *const LIB_NAME;
		[Field ("LIB_NAME", "__Internal")]
		NSString LIB_NAME { get; }
	}

}
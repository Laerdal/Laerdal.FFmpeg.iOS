using System;
using Foundation;

namespace Laerdal.Xamarin.FFmpeg.iOS
{
	// @interface MediaInformationParser : NSObject
	[BaseType (typeof(NSObject))]
	[Protocol]
	interface MediaInformationParser
	{
		// +(MediaInformation *)from:(NSString *)ffprobeJsonOutput;
		[Static]
		[Export ("from:")]
		MediaInformation From (string ffprobeJsonOutput);

		// +(MediaInformation *)from:(NSString *)ffprobeJsonOutput with:(NSError *)error;
		[Static]
		[Export ("from:with:")]
		MediaInformation From (string ffprobeJsonOutput, NSError error);
	}
}

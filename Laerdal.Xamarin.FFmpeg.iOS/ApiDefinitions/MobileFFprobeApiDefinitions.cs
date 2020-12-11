using System;
using Foundation;

namespace Laerdal.Xamarin.FFmpeg.iOS
{
	// @interface MobileFFprobe : NSObject
	[BaseType (typeof(NSObject))]
	interface MobileFFprobe
	{
		// +(int)executeWithArguments:(NSArray *)arguments;
		[Static]
		[Export ("executeWithArguments:")]
		int ExecuteWithArguments (NSString[] arguments);

		// +(int)execute:(NSString *)command;
		[Static]
		[Export ("execute:")]
		int Execute (string command);

		// +(MediaInformation *)getMediaInformation:(NSString *)path;
		[Static]
		[Export ("getMediaInformation:")]
		MediaInformation GetMediaInformation (string path);

		// +(MediaInformation *)getMediaInformationFromCommand:(NSString *)command;
		[Static]
		[Export ("getMediaInformationFromCommand:")]
		MediaInformation GetMediaInformationFromCommand (string command);

		// +(MediaInformation *)getMediaInformation:(NSString *)path timeout:(long)timeout __attribute__((deprecated("")));
		[Static]
		[Export ("getMediaInformation:timeout:")]
		MediaInformation GetMediaInformation (string path, nint timeout);
	}
}

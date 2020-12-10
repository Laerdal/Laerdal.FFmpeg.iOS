using System;
using Foundation;

namespace Laerdal.Xamarin.FFmpeg.iOS
{
	// @interface MediaInformation : NSObject
	[BaseType (typeof(NSObject))]
	interface MediaInformation
	{
		// -(instancetype)init:(NSDictionary *)mediaDictionary withStreams:(NSArray *)streams;
		[Export ("init:withStreams:")]
		IntPtr Constructor (NSDictionary mediaDictionary, NSStream[] streams);

		// -(NSString *)getFilename;
		[Export ("getFilename")]
		string Filename { get; }

		// -(NSString *)getFormat;
		[Export ("getFormat")]
		string Format { get; }

		// -(NSString *)getLongFormat;
		[Export ("getLongFormat")]
		string LongFormat { get; }

		// -(NSString *)getDuration;
		[Export ("getDuration")]
		string Duration { get; }

		// -(NSString *)getStartTime;
		[Export ("getStartTime")]
		string StartTime { get; }

		// -(NSString *)getSize;
		[Export ("getSize")]
		string Size { get; }

		// -(NSString *)getBitrate;
		[Export ("getBitrate")]
		string Bitrate { get; }

		// -(NSDictionary *)getTags;
		[Export ("getTags")]
		NSDictionary Tags { get; }

		// -(NSArray *)getStreams;
		[Export ("getStreams")]
		NSObject[] Streams { get; }

		// -(NSString *)getStringProperty:(NSString *)key;
		[Export ("getStringProperty:")]
		string GetStringProperty (string key);

		// -(NSNumber *)getNumberProperty:(NSString *)key;
		[Export ("getNumberProperty:")]
		NSNumber GetNumberProperty (string key);

		// -(NSDictionary *)getProperties:(NSString *)key;
		[Export ("getProperties:")]
		NSDictionary GetProperties (string key);

		// -(NSDictionary *)getMediaProperties;
		[Export ("getMediaProperties")]
		NSDictionary MediaProperties { get; }

		// -(NSDictionary *)getAllProperties;
		[Export ("getAllProperties")]
		NSDictionary AllProperties { get; }
	}
}

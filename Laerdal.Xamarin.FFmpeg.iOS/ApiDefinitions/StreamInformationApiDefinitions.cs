using System;
using Foundation;

namespace Laerdal.Xamarin.FFmpeg.iOS
{
	// @interface StreamInformation : NSObject
	[BaseType (typeof(NSObject))]
	interface StreamInformation
	{
		// -(instancetype)init:(NSDictionary *)streamDictionary;
		[Export ("init:")]
		IntPtr Constructor (NSDictionary streamDictionary);

		// -(NSNumber *)getIndex;
		[Export ("getIndex")]
		NSNumber Index { get; }

		// -(NSString *)getType;
		[Export ("getType")]
		string Type { get; }

		// -(NSString *)getCodec;
		[Export ("getCodec")]
		string Codec { get; }

		// -(NSString *)getFullCodec;
		[Export ("getFullCodec")]
		string FullCodec { get; }

		// -(NSString *)getFormat;
		[Export ("getFormat")]
		string Format { get; }

		// -(NSNumber *)getWidth;
		[Export ("getWidth")]
		NSNumber Width { get; }

		// -(NSNumber *)getHeight;
		[Export ("getHeight")]
		NSNumber Height { get; }

		// -(NSString *)getBitrate;
		[Export ("getBitrate")]
		string Bitrate { get; }

		// -(NSString *)getSampleRate;
		[Export ("getSampleRate")]
		string SampleRate { get; }

		// -(NSString *)getSampleFormat;
		[Export ("getSampleFormat")]
		string SampleFormat { get; }

		// -(NSString *)getChannelLayout;
		[Export ("getChannelLayout")]
		string ChannelLayout { get; }

		// -(NSString *)getSampleAspectRatio;
		[Export ("getSampleAspectRatio")]
		string SampleAspectRatio { get; }

		// -(NSString *)getDisplayAspectRatio;
		[Export ("getDisplayAspectRatio")]
		string DisplayAspectRatio { get; }

		// -(NSString *)getAverageFrameRate;
		[Export ("getAverageFrameRate")]
		string AverageFrameRate { get; }

		// -(NSString *)getRealFrameRate;
		[Export ("getRealFrameRate")]
		string RealFrameRate { get; }

		// -(NSString *)getTimeBase;
		[Export ("getTimeBase")]
		string TimeBase { get; }

		// -(NSString *)getCodecTimeBase;
		[Export ("getCodecTimeBase")]
		string CodecTimeBase { get; }

		// -(NSDictionary *)getTags;
		[Export ("getTags")]
		NSDictionary Tags { get; }

		// -(NSString *)getStringProperty:(NSString *)key;
		[Export ("getStringProperty:")]
		string GetStringProperty (string key);

		// -(NSNumber *)getNumberProperty:(NSString *)key;
		[Export ("getNumberProperty:")]
		NSNumber GetNumberProperty (string key);

		// -(NSDictionary *)getProperties:(NSString *)key;
		[Export ("getProperties:")]
		NSDictionary GetProperties (string key);

		// -(NSDictionary *)getAllProperties;
		[Export ("getAllProperties")]
		NSDictionary AllProperties { get; }
	}
}

using System;
using Foundation;
using mobileffmpeg;

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
		[Verify (MethodToProperty)]
		NSNumber Index { get; }

		// -(NSString *)getType;
		[Export ("getType")]
		[Verify (MethodToProperty)]
		string Type { get; }

		// -(NSString *)getCodec;
		[Export ("getCodec")]
		[Verify (MethodToProperty)]
		string Codec { get; }

		// -(NSString *)getFullCodec;
		[Export ("getFullCodec")]
		[Verify (MethodToProperty)]
		string FullCodec { get; }

		// -(NSString *)getFormat;
		[Export ("getFormat")]
		[Verify (MethodToProperty)]
		string Format { get; }

		// -(NSNumber *)getWidth;
		[Export ("getWidth")]
		[Verify (MethodToProperty)]
		NSNumber Width { get; }

		// -(NSNumber *)getHeight;
		[Export ("getHeight")]
		[Verify (MethodToProperty)]
		NSNumber Height { get; }

		// -(NSString *)getBitrate;
		[Export ("getBitrate")]
		[Verify (MethodToProperty)]
		string Bitrate { get; }

		// -(NSString *)getSampleRate;
		[Export ("getSampleRate")]
		[Verify (MethodToProperty)]
		string SampleRate { get; }

		// -(NSString *)getSampleFormat;
		[Export ("getSampleFormat")]
		[Verify (MethodToProperty)]
		string SampleFormat { get; }

		// -(NSString *)getChannelLayout;
		[Export ("getChannelLayout")]
		[Verify (MethodToProperty)]
		string ChannelLayout { get; }

		// -(NSString *)getSampleAspectRatio;
		[Export ("getSampleAspectRatio")]
		[Verify (MethodToProperty)]
		string SampleAspectRatio { get; }

		// -(NSString *)getDisplayAspectRatio;
		[Export ("getDisplayAspectRatio")]
		[Verify (MethodToProperty)]
		string DisplayAspectRatio { get; }

		// -(NSString *)getAverageFrameRate;
		[Export ("getAverageFrameRate")]
		[Verify (MethodToProperty)]
		string AverageFrameRate { get; }

		// -(NSString *)getRealFrameRate;
		[Export ("getRealFrameRate")]
		[Verify (MethodToProperty)]
		string RealFrameRate { get; }

		// -(NSString *)getTimeBase;
		[Export ("getTimeBase")]
		[Verify (MethodToProperty)]
		string TimeBase { get; }

		// -(NSString *)getCodecTimeBase;
		[Export ("getCodecTimeBase")]
		[Verify (MethodToProperty)]
		string CodecTimeBase { get; }

		// -(NSDictionary *)getTags;
		[Export ("getTags")]
		[Verify (MethodToProperty)]
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
		[Verify (MethodToProperty)]
		NSDictionary AllProperties { get; }
	}

	// @interface MediaInformation : NSObject
	[BaseType (typeof(NSObject))]
	interface MediaInformation
	{
		// -(instancetype)init:(NSDictionary *)mediaDictionary withStreams:(NSArray *)streams;
		[Export ("init:withStreams:")]
		[Verify (StronglyTypedNSArray)]
		IntPtr Constructor (NSDictionary mediaDictionary, NSObject[] streams);

		// -(NSString *)getFilename;
		[Export ("getFilename")]
		[Verify (MethodToProperty)]
		string Filename { get; }

		// -(NSString *)getFormat;
		[Export ("getFormat")]
		[Verify (MethodToProperty)]
		string Format { get; }

		// -(NSString *)getLongFormat;
		[Export ("getLongFormat")]
		[Verify (MethodToProperty)]
		string LongFormat { get; }

		// -(NSString *)getDuration;
		[Export ("getDuration")]
		[Verify (MethodToProperty)]
		string Duration { get; }

		// -(NSString *)getStartTime;
		[Export ("getStartTime")]
		[Verify (MethodToProperty)]
		string StartTime { get; }

		// -(NSString *)getSize;
		[Export ("getSize")]
		[Verify (MethodToProperty)]
		string Size { get; }

		// -(NSString *)getBitrate;
		[Export ("getBitrate")]
		[Verify (MethodToProperty)]
		string Bitrate { get; }

		// -(NSDictionary *)getTags;
		[Export ("getTags")]
		[Verify (MethodToProperty)]
		NSDictionary Tags { get; }

		// -(NSArray *)getStreams;
		[Export ("getStreams")]
		[Verify (MethodToProperty), Verify (StronglyTypedNSArray)]
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
		[Verify (MethodToProperty)]
		NSDictionary MediaProperties { get; }

		// -(NSDictionary *)getAllProperties;
		[Export ("getAllProperties")]
		[Verify (MethodToProperty)]
		NSDictionary AllProperties { get; }
	}

	// @interface MediaInformationParser : NSObject
	[BaseType (typeof(NSObject))]
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

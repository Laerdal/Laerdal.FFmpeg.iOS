using System;
using Foundation;

namespace Laerdal.Xamarin.FFmpeg.iOS
{
	// @interface Statistics : NSObject
	[BaseType (typeof(NSObject), Name = "Statistics")]
	[Protocol]
	interface Statistics
	{
		// -(instancetype)initWithId:(long)currentExecutionId videoFrameNumber:(int)newVideoFrameNumber fps:(float)newVideoFps quality:(float)newVideoQuality size:(int64_t)newSize time:(int)newTime bitrate:(double)newBitrate speed:(double)newSpeed;
		[Export ("initWithId:videoFrameNumber:fps:quality:size:time:bitrate:speed:")]
		IntPtr Constructor (nint currentExecutionId, int newVideoFrameNumber, float newVideoFps, float newVideoQuality, long newSize, int newTime, double newBitrate, double newSpeed);

		// -(void)update:(Statistics *)statistics;
		[Export ("update:")]
		void Update (Statistics statistics);

		// -(long)getExecutionId;
		[Export ("getExecutionId")]
		nint ExecutionId { get; }

		// -(int)getVideoFrameNumber;
		[Export ("getVideoFrameNumber")]
		int VideoFrameNumber { get; }

		// -(float)getVideoFps;
		[Export ("getVideoFps")]
		float VideoFps { get; }

		// -(float)getVideoQuality;
		[Export ("getVideoQuality")]
		float VideoQuality { get; }

		// -(long)getSize;
		[Export ("getSize")]
		nint Size { get; }

		// -(int)getTime;
		[Export ("getTime")]
		int Time { get; }

		// -(double)getBitrate;
		[Export ("getBitrate")]
		double Bitrate { get; }

		// -(double)getSpeed;
		[Export ("getSpeed")]
		double Speed { get; }
	}
}

using System;
using Foundation;
using mobileffmpeg;

namespace Laerdal.Xamarin.FFmpeg.iOS
{
	// @interface Statistics : NSObject
	[BaseType (typeof(NSObject))]
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
		[Verify (MethodToProperty)]
		nint ExecutionId { get; }

		// -(int)getVideoFrameNumber;
		[Export ("getVideoFrameNumber")]
		[Verify (MethodToProperty)]
		int VideoFrameNumber { get; }

		// -(float)getVideoFps;
		[Export ("getVideoFps")]
		[Verify (MethodToProperty)]
		float VideoFps { get; }

		// -(float)getVideoQuality;
		[Export ("getVideoQuality")]
		[Verify (MethodToProperty)]
		float VideoQuality { get; }

		// -(long)getSize;
		[Export ("getSize")]
		[Verify (MethodToProperty)]
		nint Size { get; }

		// -(int)getTime;
		[Export ("getTime")]
		[Verify (MethodToProperty)]
		int Time { get; }

		// -(double)getBitrate;
		[Export ("getBitrate")]
		[Verify (MethodToProperty)]
		double Bitrate { get; }

		// -(double)getSpeed;
		[Export ("getSpeed")]
		[Verify (MethodToProperty)]
		double Speed { get; }
	}
}

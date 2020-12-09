using System;
using Foundation;
using mobileffmpeg;

namespace Laerdal.Xamarin.FFmpeg.iOS
{
	// @protocol LogDelegate <NSObject>
	[Protocol, Model]
	[BaseType (typeof(NSObject))]
	interface LogDelegate
	{
		// @required -(void)logCallback:(long)executionId :(int)level :(NSString *)message;
		[Abstract]
		[Export ("logCallback:::")]
		void  (nint executionId, int level, string message);
	}

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

	// @protocol StatisticsDelegate <NSObject>
	[Protocol, Model]
	[BaseType (typeof(NSObject))]
	interface StatisticsDelegate
	{
		// @required -(void)statisticsCallback:(Statistics *)statistics;
		[Abstract]
		[Export ("statisticsCallback:")]
		void StatisticsCallback (Statistics statistics);
	}

	[Static]
	[Verify (ConstantsInterfaceAssociation)]
	partial interface Constants
	{
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

	// @interface MobileFFmpegConfig : NSObject
	[BaseType (typeof(NSObject))]
	interface MobileFFmpegConfig
	{
		// +(void)enableRedirection;
		[Static]
		[Export ("enableRedirection")]
		void EnableRedirection ();

		// +(void)disableRedirection;
		[Static]
		[Export ("disableRedirection")]
		void DisableRedirection ();

		// +(int)getLogLevel;
		[Static]
		[Export ("getLogLevel")]
		[Verify (MethodToProperty)]
		int LogLevel { get; }

		// +(void)setLogLevel:(int)level;
		[Static]
		[Export ("setLogLevel:")]
		void SetLogLevel (int level);

		// +(NSString *)logLevelToString:(int)level;
		[Static]
		[Export ("logLevelToString:")]
		string LogLevelToString (int level);

		// +(void)setLogDelegate:(id<LogDelegate>)newLogDelegate;
		[Static]
		[Export ("setLogDelegate:")]
		void SetLogDelegate (LogDelegate newLogDelegate);

		// +(void)setStatisticsDelegate:(id<StatisticsDelegate>)newStatisticsDelegate;
		[Static]
		[Export ("setStatisticsDelegate:")]
		void SetStatisticsDelegate (StatisticsDelegate newStatisticsDelegate);

		// +(Statistics *)getLastReceivedStatistics;
		[Static]
		[Export ("getLastReceivedStatistics")]
		[Verify (MethodToProperty)]
		Statistics LastReceivedStatistics { get; }

		// +(void)resetStatistics;
		[Static]
		[Export ("resetStatistics")]
		void ResetStatistics ();

		// +(void)setFontconfigConfigurationPath:(NSString *)path;
		[Static]
		[Export ("setFontconfigConfigurationPath:")]
		void SetFontconfigConfigurationPath (string path);

		// +(void)setFontDirectory:(NSString *)fontDirectoryPath with:(NSDictionary *)fontNameMapping;
		[Static]
		[Export ("setFontDirectory:with:")]
		void SetFontDirectory (string fontDirectoryPath, NSDictionary fontNameMapping);

		// +(NSString *)getPackageName;
		[Static]
		[Export ("getPackageName")]
		[Verify (MethodToProperty)]
		string PackageName { get; }

		// +(NSArray *)getExternalLibraries;
		[Static]
		[Export ("getExternalLibraries")]
		[Verify (MethodToProperty), Verify (StronglyTypedNSArray)]
		NSObject[] ExternalLibraries { get; }

		// +(NSString *)registerNewFFmpegPipe;
		[Static]
		[Export ("registerNewFFmpegPipe")]
		[Verify (MethodToProperty)]
		string RegisterNewFFmpegPipe { get; }

		// +(void)closeFFmpegPipe:(NSString *)ffmpegPipePath;
		[Static]
		[Export ("closeFFmpegPipe:")]
		void CloseFFmpegPipe (string ffmpegPipePath);

		// +(NSString *)getFFmpegVersion;
		[Static]
		[Export ("getFFmpegVersion")]
		[Verify (MethodToProperty)]
		string FFmpegVersion { get; }

		// +(NSString *)getVersion;
		[Static]
		[Export ("getVersion")]
		[Verify (MethodToProperty)]
		string Version { get; }

		// +(NSString *)getBuildDate;
		[Static]
		[Export ("getBuildDate")]
		[Verify (MethodToProperty)]
		string BuildDate { get; }

		// +(int)getLastReturnCode;
		[Static]
		[Export ("getLastReturnCode")]
		[Verify (MethodToProperty)]
		int LastReturnCode { get; }

		// +(NSString *)getLastCommandOutput;
		[Static]
		[Export ("getLastCommandOutput")]
		[Verify (MethodToProperty)]
		string LastCommandOutput { get; }

		// +(void)ignoreSignal:(int)signum;
		[Static]
		[Export ("ignoreSignal:")]
		void IgnoreSignal (int signum);
	}
}

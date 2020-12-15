using System;
using Foundation;

namespace Laerdal.Xamarin.FFmpeg.iOS
{
	// @interface MobileFFmpegConfig : NSObject
	[BaseType (typeof(NSObject))]
	[Protocol]
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
		string PackageName { get; }

		// +(NSArray *)getExternalLibraries;
		[Static]
		[Export ("getExternalLibraries")]
		NSObject[] ExternalLibraries { get; }

		// +(NSString *)registerNewFFmpegPipe;
		[Static]
		[Export ("registerNewFFmpegPipe")]
		string RegisterNewFFmpegPipe();

		// +(void)closeFFmpegPipe:(NSString *)ffmpegPipePath;
		[Static]
		[Export ("closeFFmpegPipe:")]
		void CloseFFmpegPipe (string ffmpegPipePath);

		// +(NSString *)getFFmpegVersion;
		[Static]
		[Export ("getFFmpegVersion")]
		string FFmpegVersion { get; }

		// +(NSString *)getVersion;
		[Static]
		[Export ("getVersion")]
		string Version { get; }

		// +(NSString *)getBuildDate;
		[Static]
		[Export ("getBuildDate")]
		string BuildDate { get; }

		// +(int)getLastReturnCode;
		[Static]
		[Export ("getLastReturnCode")]
		int LastReturnCode { get; }

		// +(NSString *)getLastCommandOutput;
		[Static]
		[Export ("getLastCommandOutput")]
		string LastCommandOutput { get; }

		// +(void)ignoreSignal:(int)signum;
		[Static]
		[Export ("ignoreSignal:")]
		void IgnoreSignal (int signum);
	}
}

using System;
using CoreFoundation;
using Foundation;

namespace Laerdal.Xamarin.FFmpeg.iOS
{
	// @protocol ExecuteDelegate <NSObject>
	[Protocol, Model]
	[BaseType (typeof(NSObject))]
	interface ExecuteDelegate
	{
		// @required -(void)executeCallback:(long)executionId :(int)returnCode;
		[Abstract]
		[Export ("executeCallback::")]
		void  (nint executionId, int returnCode);
	}

	[Static]
	[Verify (ConstantsInterfaceAssociation)]
	partial interface Constants
	{
		// extern NSString *const MOBILE_FFMPEG_VERSION;
		[Field ("MOBILE_FFMPEG_VERSION", "__Internal")]
		NSString MOBILE_FFMPEG_VERSION { get; }
	}

	// @interface MobileFFmpeg : NSObject
	[BaseType (typeof(NSObject))]
	interface MobileFFmpeg
	{
		// +(int)executeWithArguments:(NSArray *)arguments;
		[Static]
		[Export ("executeWithArguments:")]
		[Verify (StronglyTypedNSArray)]
		int ExecuteWithArguments (NSObject[] arguments);

		// +(int)executeWithArgumentsAsync:(NSArray *)arguments withCallback:(id<ExecuteDelegate>)delegate;
		[Static]
		[Export ("executeWithArgumentsAsync:withCallback:")]
		[Verify (StronglyTypedNSArray)]
		int ExecuteWithArgumentsAsync (NSObject[] arguments, ExecuteDelegate @delegate);

		// +(int)executeWithArgumentsAsync:(NSArray *)arguments withCallback:(id<ExecuteDelegate>)delegate andDispatchQueue:(dispatch_queue_t)queue;
		[Static]
		[Export ("executeWithArgumentsAsync:withCallback:andDispatchQueue:")]
		[Verify (StronglyTypedNSArray)]
		int ExecuteWithArgumentsAsync (NSObject[] arguments, ExecuteDelegate @delegate, DispatchQueue queue);

		// +(int)execute:(NSString *)command;
		[Static]
		[Export ("execute:")]
		int Execute (string command);

		// +(int)executeAsync:(NSString *)command withCallback:(id<ExecuteDelegate>)delegate;
		[Static]
		[Export ("executeAsync:withCallback:")]
		int ExecuteAsync (string command, ExecuteDelegate @delegate);

		// +(int)executeAsync:(NSString *)command withCallback:(id<ExecuteDelegate>)delegate andDispatchQueue:(dispatch_queue_t)queue;
		[Static]
		[Export ("executeAsync:withCallback:andDispatchQueue:")]
		int ExecuteAsync (string command, ExecuteDelegate @delegate, DispatchQueue queue);

		// +(int)execute:(NSString *)command delimiter:(NSString *)delimiter __attribute__((deprecated("")));
		[Static]
		[Export ("execute:delimiter:")]
		int Execute (string command, string delimiter);

		// +(void)cancel;
		[Static]
		[Export ("cancel")]
		void Cancel ();

		// +(void)cancel:(long)executionId;
		[Static]
		[Export ("cancel:")]
		void Cancel (nint executionId);

		// +(NSArray *)parseArguments:(NSString *)command;
		[Static]
		[Export ("parseArguments:")]
		[Verify (StronglyTypedNSArray)]
		NSObject[] ParseArguments (string command);

		// +(NSString *)argumentsToString:(NSArray *)arguments;
		[Static]
		[Export ("argumentsToString:")]
		[Verify (StronglyTypedNSArray)]
		string ArgumentsToString (NSObject[] arguments);

		// +(NSArray *)listExecutions;
		[Static]
		[Export ("listExecutions")]
		[Verify (MethodToProperty), Verify (StronglyTypedNSArray)]
		NSObject[] ListExecutions { get; }
	}
}

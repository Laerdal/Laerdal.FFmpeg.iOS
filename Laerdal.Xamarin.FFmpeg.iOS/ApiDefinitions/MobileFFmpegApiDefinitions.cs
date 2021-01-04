using System;
using CoreFoundation;
using Foundation;

namespace Laerdal.Xamarin.FFmpeg.iOS
{
	// @interface MobileFFmpeg : NSObject
	[BaseType (typeof(NSObject), Name = "MobileFFmpeg")]
	[Protocol]
	interface MobileFFmpeg
	{
		// +(int)executeWithArguments:(NSArray *)arguments;
		[Static, Export ("executeWithArguments:")]
		int ExecuteWithArguments (NSString[] arguments);

		// +(int)executeWithArgumentsAsync:(NSArray *)arguments withCallback:(id<ExecuteDelegate>)delegate;
		[Static, Export ("executeWithArgumentsAsync:withCallback:")]
		int ExecuteWithArgumentsAsync (NSString[] arguments, IExecuteDelegate @delegate);

		// +(int)executeWithArgumentsAsync:(NSArray *)arguments withCallback:(id<ExecuteDelegate>)delegate andDispatchQueue:(dispatch_queue_t)queue;
		[Static, Export ("executeWithArgumentsAsync:withCallback:andDispatchQueue:")]
		int ExecuteWithArgumentsAsync (NSString[] arguments, IExecuteDelegate @delegate, DispatchQueue queue);

		// +(int)execute:(NSString *)command;
		[Static, Export ("execute:")]
		int Execute (string command);

		// +(int)executeAsync:(NSString *)command withCallback:(id<ExecuteDelegate>)delegate;
		[Static, Export ("executeAsync:withCallback:")]
		int ExecuteAsync (string command, IExecuteDelegate @delegate);

		// +(int)executeAsync:(NSString *)command withCallback:(id<ExecuteDelegate>)delegate andDispatchQueue:(dispatch_queue_t)queue;
		[Static, Export ("executeAsync:withCallback:andDispatchQueue:")]
		int ExecuteAsync (string command, IExecuteDelegate @delegate, DispatchQueue queue);

		// +(int)execute:(NSString *)command delimiter:(NSString *)delimiter __attribute__((deprecated("")));
		[Static, Export ("execute:delimiter:")]
		int Execute (string command, string delimiter);

		// +(void)cancel;
		[Static, Export ("cancel")]
		void Cancel ();

		// +(void)cancel:(long)executionId;
		[Static, Export ("cancel:")]
		void Cancel (nint executionId);

		// +(NSArray *)parseArguments:(NSString *)command;
		[Static, Export ("parseArguments:")]
		NSObject[] ParseArguments (string command);

		// +(NSString *)argumentsToString:(NSArray *)arguments;
		[Static, Export ("argumentsToString:")]
		string ArgumentsToString (NSString[] arguments);

		// +(NSArray *)listExecutions;
		[Static, Export ("listExecutions")]
		NSObject[] ListExecutions { get; }
	}
}

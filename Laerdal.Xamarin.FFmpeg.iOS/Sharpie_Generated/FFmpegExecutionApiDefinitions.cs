using System;
using Foundation;

namespace Laerdal.Xamarin.FFmpeg.iOS
{
	// @interface FFmpegExecution : NSObject
	[BaseType (typeof(NSObject))]
	interface FFmpegExecution
	{
		// -(instancetype)initWithExecutionId:(long)newExecutionId andArguments:(NSArray *)arguments;
		[Export ("initWithExecutionId:andArguments:")]
		[Verify (StronglyTypedNSArray)]
		IntPtr Constructor (nint newExecutionId, NSObject[] arguments);

		// -(NSDate *)getStartTime;
		[Export ("getStartTime")]
		[Verify (MethodToProperty)]
		NSDate StartTime { get; }

		// -(long)getExecutionId;
		[Export ("getExecutionId")]
		[Verify (MethodToProperty)]
		nint ExecutionId { get; }

		// -(NSString *)getCommand;
		[Export ("getCommand")]
		[Verify (MethodToProperty)]
		string Command { get; }
	}
}

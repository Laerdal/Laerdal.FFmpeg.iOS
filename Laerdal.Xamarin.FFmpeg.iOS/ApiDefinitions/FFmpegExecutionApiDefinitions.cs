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
        IntPtr Constructor (nint newExecutionId, NSString[] arguments);

        // -(NSDate *)getStartTime;
        [Export ("getStartTime")]
        NSDate StartTime { get; }

        // -(long)getExecutionId;
        [Export ("getExecutionId")]
        nint ExecutionId { get; }

        // -(NSString *)getCommand;
        [Export ("getCommand")]
        string Command { get; }
    }
}
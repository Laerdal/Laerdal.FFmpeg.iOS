using System;
using Foundation;

namespace Framinosona.Xamarin.FFmpeg.iOS
{
	// @protocol LogDelegate
	[Protocol, Model]
	[BaseType (typeof(NSObject))]
	interface LogDelegate
	{
		// @required -(void)logCallback:(long)executionId :(int)level :(id)message;
		[Abstract]
		[Export ("logCallback:::")]
		void LogCallback(nint executionId, int level, NSObject message);
	}
}

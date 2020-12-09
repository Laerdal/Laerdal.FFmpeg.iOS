using System;
using Foundation;

namespace Laerdal.Xamarin.FFmpeg.iOS
{
	// @protocol LogDelegate
	[Protocol, Model]
	interface LogDelegate
	{
		// @required -(void)logCallback:(long)executionId :(int)level :(id)message;
		[Abstract]
		[Export ("logCallback:::")]
		void  (nint executionId, int level, NSObject message);
	}
}

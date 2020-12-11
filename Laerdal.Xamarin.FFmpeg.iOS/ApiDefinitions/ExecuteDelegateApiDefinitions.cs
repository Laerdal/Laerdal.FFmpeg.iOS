using System;
using Foundation;

namespace Laerdal.Xamarin.FFmpeg.iOS
{
	// @protocol ExecuteDelegate
	[Protocol, Model]
	[BaseType (typeof(NSObject))]
	interface ExecuteDelegate
	{
		// @required -(void)executeCallback:(long)executionId :(int)returnCode;
		[Abstract]
		[Export ("executeCallback::")]
		void executeCallback(nint executionId, int returnCode);
	}
}

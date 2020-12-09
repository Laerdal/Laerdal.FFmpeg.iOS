using System;
using Foundation;

namespace Laerdal.Xamarin.FFmpeg.iOS
{
	// @protocol ExecuteDelegate
	[Protocol, Model]
	interface ExecuteDelegate
	{
		// @required -(void)executeCallback:(long)executionId :(int)returnCode;
		[Abstract]
		[Export ("executeCallback::")]
		void  (nint executionId, int returnCode);
	}
}

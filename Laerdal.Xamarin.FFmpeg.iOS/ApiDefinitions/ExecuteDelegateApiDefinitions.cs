using System;
using Foundation;

namespace Laerdal.Xamarin.FFmpeg.iOS
{
	// @protocol ExecuteDelegate
	[BaseType (typeof(NSObject), Name = "ExecuteDelegate")]
	[Protocol, Model]
	interface ExecuteDelegate
	{
		// @required -(void)executeCallback:(long)executionId :(int)returnCode;
		[Abstract, Export ("executeCallback::")]
		void executeCallback(nint executionId, int returnCode);
	}

	public interface IExecuteDelegate {}
}

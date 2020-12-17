using System;
using Foundation;

namespace Laerdal.Xamarin.FFmpeg.iOS
{
	// @protocol LogDelegate
	[BaseType (typeof(NSObject), Name = "LogDelegate")]
	[Protocol, Model]
	interface LogDelegate
	{
		// @required -(void)logCallback:(long)executionId :(int)level :(id)message;
		[Abstract, Export ("logCallback:::")]
		void LogCallback(nint executionId, int level, NSObject message);
	}

	public interface ILogDelegate {}
}

using System;
using Foundation;

namespace Laerdal.Xamarin.FFmpeg.iOS
{
	// @protocol StatisticsDelegate <NSObject>
	[Protocol, Model]
	[BaseType (typeof(NSObject))]
	interface StatisticsDelegate
	{
		// @required -(void)statisticsCallback:(Statistics *)statistics;
		[Abstract]
		[Export ("statisticsCallback:")]
		void StatisticsCallback (Statistics statistics);
	}
}

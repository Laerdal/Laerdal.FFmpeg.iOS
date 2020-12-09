using System;
using Foundation;

namespace Framinosona.Xamarin.FFmpeg.iOS
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

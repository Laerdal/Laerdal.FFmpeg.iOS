using System;
using Foundation;

namespace Laerdal.Xamarin.FFmpeg.iOS
{
	// @protocol StatisticsDelegate <NSObject>
	[BaseType (typeof(NSObject), Name = "StatisticsDelegate")]
	[Protocol, Model]
	interface StatisticsDelegate
	{
		// @required -(void)statisticsCallback:(Statistics *)statistics;
		[Abstract, Export ("statisticsCallback:")]
		void StatisticsCallback (Statistics statistics);
	}
	
	public interface IStatisticsDelegate {}
}

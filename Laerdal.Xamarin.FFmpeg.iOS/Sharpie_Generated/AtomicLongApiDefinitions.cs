using System;
using Foundation;

namespace Laerdal.Xamarin.FFmpeg.iOS
{
	// @interface AtomicLong : NSObject
	[BaseType (typeof(NSObject))]
	interface AtomicLong
	{
		// -(instancetype)initWithInitialValue:(long)initialValue;
		[Export ("initWithInitialValue:")]
		IntPtr Constructor (nint initialValue);

		// -(long)incrementAndGet;
		[Export ("incrementAndGet")]
		[Verify (MethodToProperty)]
		nint IncrementAndGet { get; }
	}
}

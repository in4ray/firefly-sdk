package com.firefly.appodeal
{
	import starling.events.Event;
	
	public class AdEvent extends Event
	{
		public static const INTERSTITIAL_SHOWED:String = "interstitialShowed";
		public static const BANNER_SHOWED:String = "bannerShowed";
		public static const SKIPPABLE_VIDEO_SHOWED:String = "skippableVideoShowed";
		public static const NON_SKIPPABLE_VIDEO_SHOWED:String = "nonSkippableVideoShowed";
		public static const REWARDED_VIDEO_SHOWED:String = "rewordedVideoShowed";
		
		public function AdEvent(type:String)
		{
			super(type);
		}
	}
}
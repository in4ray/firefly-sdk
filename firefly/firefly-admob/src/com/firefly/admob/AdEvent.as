// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.admob
{
	import starling.events.Event;
	
	public class AdEvent extends Event
	{
		public static const INTERSTITIAL_SHOWED:String = "interstitialShowed";
		public static const BANNER_SHOWED:String = "bannerShowed";
		
		public function AdEvent(type:String)
		{
			super(type);
		}
	}
}
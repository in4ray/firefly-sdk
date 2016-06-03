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
	
	/** Event for AdMob manager.*/	
	public class AdEvent extends Event
	{
		/** Interstitial ad showed.*/
		public static const INTERSTITIAL_SHOWED:String = "interstitialShowed";
		/** Banner ad showed.*/
		public static const BANNER_SHOWED:String = "bannerShowed";
		
		/** Constructor.
		 *  @param type Event type. */		
		public function AdEvent(type:String)
		{
			super(type);
		}
	}
}
// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.analytics
{
	import com.in4ray.gaming.core.SingletonLocator;
	
	import eu.alebianco.air.extensions.analytics.Analytics;
	import eu.alebianco.air.extensions.analytics.api.ITracker;

	/**
	 * Google analytics manager, used to send analytics to Google server.
	 * 
	 * @see http://www.google.com/analytics/ 
	 * 
	 * @example The following example shows how to use GoogleAnalytics:
	 *
	 * <listing version="3.0">
import com.in4ray.games.core.analytics.Googleanalytics;
import com.in4ray.games.core.components.flash.GameApplication;

public class SampleGame extends GameApplication
{
	private var analytics:GoogleAnalytics;
	
	public function SampleGame()
	{
		super();
		
		...
		 * 
		// Initialize Google Analytics
		analytics = new GoogleAnalytics("SampleGame", "MY_GA_TRACKER_ID");
		analytics.log("Page", "Initialization");
	}
}

import com.in4ray.games.core.analytics.IAnalytics;
import com.in4ray.games.core.components.Sprite;
import com.in4ray.games.core.managers.SingletonLocator;

public class MainView extends Sprite
{
	private var analytics:IAnalytics;
	
	public function MainView()
	{
		analytics = SingletonLocator.getInstance(IAnalytics);
	}
	
	public function myAction():void
	{
		analytics.log("Game", "myAction");
	}
}
	 * </listing>
	 */	
	public class GoogleAnalytics implements IAnalytics
	{
		/**
		 * Constructor. This class register itself in singleton locator for Ianalytics interface, 
		 * after instantiating you can access it by SingeltonLocator.getInstance(Ianalytics).
		 *  
		 * @param gameName Name of game.
		 * @param trackingId Identifier of google tracker.
		 * @param interval Number of seconds while meneger caches events before sending.
		 * @param debug Debug mode.
		 */		
		public function GoogleAnalytics(gameName:String, trackingId:String, interval:int = 20, debug:Boolean = false)
		{
			this.gameName = gameName;
			this.trackingId = trackingId;
			
			if (Analytics.isSupported())
			{
				analytics = Analytics.getInstance();
				analytics.debug = debug;
				analytics.dispatchInterval = interval;
				
				tracker = analytics.getTracker(trackingId);
				tracker.startNewSession();
			}
			
			SingletonLocator.register(IAnalytics, this);
		}
		
		private var analytics:Analytics;
		private var trackingId:String;
		private var tracker:ITracker;
		private var gameName:String;
		
		/**
		 * @inheritDoc 
		 */		
		public function log(action:String, label:String):void
		{
			if(tracker)
				tracker.buildEvent(gameName, action).withLabel(label).track();
		}
		
		/**
		 * @inheritDoc 
		 */			
		public function send():void
		{
		}
	}
}

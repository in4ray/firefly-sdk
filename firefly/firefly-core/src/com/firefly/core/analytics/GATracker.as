// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.analytics
{
	import com.firefly.core.Firefly;
	import com.firefly.core.firefly_internal;
	import com.firefly.core.controllers.ScreenNavigatorCtrl;
	import com.firefly.core.events.ScreenNavigatorEvent;
	import com.firefly.core.utils.SingletonLocator;
	
	import eu.alebianco.air.extensions.analytics.Analytics;
	import eu.alebianco.air.extensions.analytics.api.ITracker;

	use namespace firefly_internal;
	
	public class GATracker
	{
		private var _model:GAModel;
		private var _analytics:Analytics;
		private var _tracker:ITracker;
		
		private var _screens:Vector.<String> = new Vector.<String>();
		
		public function GATracker()
		{
			SingletonLocator.register(this, GATracker);
		}
		
		public static function get instance():GATracker {	return SingletonLocator.getInstance(GATracker); }
		
		public function init(trackerId:String, appName:String, appVersion:String = "1.0", dispatchInterval:uint = 20, debug:Boolean=false):void
		{
			_model = new GAModel(trackerId);
			Firefly.current.addModel(_model);
			
			if(Analytics.isSupported())
			{
				_analytics = Analytics.getInstance();
				_analytics.dispatchInterval = dispatchInterval;
				_analytics.debug = debug;
				
				_tracker = _analytics.getTracker(trackerId);
				_tracker.appName = appName;
				_tracker.appVersion = appVersion;
			}
		}

		public function get analytics():Analytics {	return _analytics; }
		public function get tracker():ITracker { return _tracker; }

		public function setCustomMetric(index:uint, value:int):void
		{
			if(_tracker)
				_tracker.setCustomMetric(index, value);
		}
		
		public function setCustomDimension(index:uint, value:String):void
		{
			if(_tracker)
				_tracker.setCustomDimension(index, value);
		}
		
		public function trackView(screenName:String):void
		{
			if(_tracker)
				_tracker.buildView(screenName).track();
		}
		
		public function trackEvent(category:String, action:String):void
		{
			if(_tracker)
				_tracker.buildEvent(category, action).track();
		}
		
		public function sendInitialData():void
		{
			setCustomDimension(1, _model.startDate);
			trackEvent("Category_Analytics", "Action_StartDate");
		}
		
		public function regScreens(controller:ScreenNavigatorCtrl, ...screenStates):void
		{
			if(_tracker)
			{
				if(_screens.length == 0)
					controller.addEventListener(ScreenNavigatorEvent.STATE_CHANGED, onScreenChanged);
				
				for each (var state:String in screenStates) 
				{
					_screens.push(state);
				}
			}
		}
		
		private function onScreenChanged(e:ScreenNavigatorEvent):void
		{
			if(_screens.indexOf(e.state) != -1)
				trackView(e.state);
		}
	}
}
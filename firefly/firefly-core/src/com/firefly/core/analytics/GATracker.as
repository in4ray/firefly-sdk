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
	
	import flash.desktop.NativeApplication;
	
	import eu.alebianco.air.extensions.analytics.Analytics;
	import eu.alebianco.air.extensions.analytics.api.ITracker;

	use namespace firefly_internal;
	
	/** The extended Google Analytics tracker which can be easily integrated into the screen components. 
	 * 
	 *  @example The following example shows how initialize the Google Analytics tracker:
	 *  <listing version="3.0">
	 *************************************************************************************
public class MyGame extends GameApp
{
	 public function MyGame()
	 {
		 super();
		 
		 GATracker.instance.init("Your Google Analytics id", "MyGame", "1.0", 20, true);
	 }
	 
	 override protected function init():void
	 {
		 super.init();
		
		 GATracker.instance.sendInitialData();
	 }
}
	 *************************************************************************************
	 *  </listing>
	 * 
	 *  @example The following example shows how register switching between screen in Google Analytics tracker:
	 *  <listing version="3.0">
	 *************************************************************************************
public class MainScreen extends ScreenNavigator
{
	 public function MainScreen()
	 {
		 super();
		 
		 var loadingTransition:BasicTransition = new BasicTransition(new MyLoadingScreen()); 
		 
		 assetManager.addState(new AssetState(GameState.COMMON, new TextureBundle(), new LocalizationBundle()));
		 
		 controller.regScreen(GameState.MENU, MenuScreen, GameState.COMMON);
		 controller.regScreen(GameState.GAME, GameScreen, GameState.COMMON);
		 controller.regScreen(GameState.SCORE, ScoreScreen, GameState.COMMON);
		 
		 // GA config
		 GATracker.instance.regScreens(controller, GameState.MENU, GameState.GAME, GameState.SCORE);
	 }
}
	 *************************************************************************************
	 *  </listing>
	 */	
	public class GATracker
	{
		/** @private */
		private var _model:GAModel;
		/** @private */
		private var _analytics:Analytics;
		/** @private */
		private var _tracker:ITracker;
		/** @private */
		private var _screens:Vector.<String> = new Vector.<String>();
		
		/** Constructor. */		
		public function GATracker()
		{
			SingletonLocator.register(this, GATracker);
		}
		
		/** Instance of Google Analytics tracker. */		
		public static function get instance():GATracker {return SingletonLocator.getInstance(GATracker); }
		
		/** Original analytics component. */		
		public function get analytics():Analytics {	return _analytics; }
		/** Original tracker component. */
		public function get tracker():ITracker { return _tracker; }
		
		/** Function for initializing Google Analytics tracker.
		 * 
		 *  @param trackerId Google Analytics tracker id.
		 *  @param appName Application name.
		 *  @param appVersion Application version.
		 *  @param dispatchInterval Interval how ofter send information to the Google Analytics in seconds.
		 *  @param debug Enable or disable debig mode. */		
		public function init(trackerId:String, appName:String, appVersion:String = "", dispatchInterval:uint = 20, debug:Boolean=false):void
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
				
				if(!appVersion)
				{
					try
					{
						var xml:XML = NativeApplication.nativeApplication.applicationDescriptor;
						var ns:Namespace = xml.namespace();
						_tracker.appVersion = xml.ns::versionNumber;
					} 
					catch(error:Error) {}
				}
			}
		}

		/** The function sends custom metric to the Google Analytics.
		 *  @param index The custom metric index.
		 *  @param value The value for custom metric. */		
		public function setCustomMetric(index:uint, value:int):void
		{
			if(_tracker)
				_tracker.setCustomMetric(index, value);
		}
		
		/** The function sends custom dimension to the Google Analytics.
		 *  @param index The custom dimension index.
		 *  @param value The value for custom dimension. */
		public function setCustomDimension(index:uint, value:String):void
		{
			if(_tracker)
				_tracker.setCustomDimension(index, value);
		}
		
		/** The function tracks view in the Google Analytics.
		 *  @param screenName The screen/view name. */
		public function trackView(screenName:String):void
		{
			if(_tracker)
				_tracker.buildView(screenName).track();
		}
		
		/** The function tracks event in the Google Analytics.
		 *  @param category Category type of the event.
		 *  @param action Action/event to track. */
		public function trackEvent(category:String, action:String):void
		{
			if(_tracker)
				_tracker.buildEvent(category, action).track();
		}
		
		/** The function tracks initial/start date. This information needs for calculating retension. */		
		public function sendInitialData():void
		{
			setCustomDimension(1, _model.startDate);
			trackEvent("Category_Analytics", "Action_StartDate");
		}
		
		/** The function registers screens for automatic tracking switching between them.
		 *  @param controller Screen navigator controller.
		 *  @param screenStates Screen states. */		
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
		
		/** @private */		
		private function onScreenChanged(e:ScreenNavigatorEvent):void
		{
			if(_screens.indexOf(e.state) != -1)
				trackView(e.state + "Screen");
		}
	}
}
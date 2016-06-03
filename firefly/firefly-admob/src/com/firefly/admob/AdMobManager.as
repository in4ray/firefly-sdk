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
	import com.firefly.core.controllers.ScreenNavigatorCtrl;
	import com.firefly.core.events.ScreenNavigatorEvent;
	import com.firefly.core.utils.Log;
	import com.firefly.core.utils.SingletonLocator;
	import com.milkmangames.nativeextensions.AdMob;
	import com.milkmangames.nativeextensions.events.AdMobErrorEvent;
	import com.milkmangames.nativeextensions.events.AdMobEvent;
	
	import flash.utils.Dictionary;
	
	import starling.events.EventDispatcher;

	[Event(name="interstitialShowed", type="com.in4ray.quadro.ad.AdEvent")]
	[Event(name="bannerShowed", type="com.in4ray.quadro.ad.AdEvent")]
	
	/** This manager requires Milkman AdMob Native Extension for Adobe AIR.
	 *  To compile code you need to buy .ane and place it into "external" library folder.
	 *  @see https://www.milkmanplugins.com/admob-air-ane */	
	public class AdMobManager extends EventDispatcher
	{
		/** @private */		
		private var _screens:Dictionary;
		/** @private */
		private var _tracker:ScreenTracker;
		/** @private */
		private var _googleIntrestitialId:String;
		/** @private */
		private var _iosIntrestitialId:String;
		/** @private */
		private var _iosBannerId:String;
		/** @private */
		private var _googleBannerId:String;
		/** @private */
		private var _ctrlListenersAdded:Boolean;
		
		/** Constructor. */		
		public function AdMobManager()
		{
			SingletonLocator.register(this, AdMobManager);
		}
		
		/** Singelton instance of AdMob manager. */		
		public static function get instance():AdMobManager {return SingletonLocator.getInstance(AdMobManager); }
		
		/** Initialize the manager.
		 *  @param googleIntrestitialId Identifier of Google Android interstitial ad.
		 *  @param iosIntrestitialId Identifier of iOS interstitial ad.
		 *  @param googleBannerId Identifier of Google Android banner ad.
		 *  @param iosBannerId Identifier of iOS banner ad.
		 *  @param devMode Enable debug/development mode. */		
		public function init(googleIntrestitialId:String=null, iosIntrestitialId:String=null, googleBannerId:String=null, iosBannerId:String=null, devMode:Boolean=false):void
		{
			if(!AdMob.isSupported)
				return;
			
			if(!googleIntrestitialId && !iosIntrestitialId)
			{
				Log.error("Interstitial ID is not set");
				return;
			}
			
			if(!googleIntrestitialId)
				googleIntrestitialId = iosIntrestitialId;
			if(!iosIntrestitialId)
				iosIntrestitialId = googleIntrestitialId;
			if(!googleBannerId)
				googleBannerId = iosBannerId;
			if(!iosBannerId)
				iosBannerId = googleBannerId;
			
			_googleBannerId = googleBannerId;
			_iosBannerId = iosBannerId;
			_iosIntrestitialId = iosIntrestitialId;
			_googleIntrestitialId = googleIntrestitialId;
			
			AdMob.init(_googleBannerId, _iosBannerId);
			AdMob.addEventListener(AdMobEvent.RECEIVED_AD, onReceiveAd);
			AdMob.addEventListener(AdMobEvent.SCREEN_DISMISSED, onAdDismissed);
			AdMob.addEventListener(AdMobErrorEvent.FAILED_TO_RECEIVE_AD, onFailedReceiveAd);
			
			if(devMode)
				AdMob.enableTestDeviceIDs(AdMob.getCurrentTestDeviceIDs());
			
			if(_googleIntrestitialId)
				AdMob.loadInterstitial(_googleIntrestitialId, false, _iosIntrestitialId);
		}
		
		/** Register screen state for showing interstitial ad on it. This type of ad will be shown when the 
		 *  game will switch to this screen state.
		 *  @param controller Screen navigator controller to know when screen state changes.
		 *  @param screenState Screen state on which the ad will be shown.
		 *  @param pereiod How often the ad will be shown for registered screen state.
		 *  @param firstShow Define to show the ad on first switching for registered screen state. */		
		public function regScreenInterstitial(controller:ScreenNavigatorCtrl, screenState:String, pereiod:int, firstShow:Boolean=false):void
		{
			if(AdMob.isSupported)
			{
				if(!_screens)
				{
					controller.addEventListener(ScreenNavigatorEvent.STATE_CHANGED, onScreenChanged);
					_screens = new Dictionary();
				}
				
				if(_screens.hasOwnProperty(screenState))
				{
					_screens[screenState].interstitial = true;
					_screens[screenState].pereiod = pereiod;
				}
				else
				{
					_screens[screenState] = new ScreenTracker(pereiod, true);
				}
				
				if(firstShow)
					_screens[screenState].count = pereiod;
			}
		}
		
		/** Register screen state for showing banner ad on it. This type of ad will be shown when the 
		 *  game will switch to this screen state.
		 *  @param controller Screen navigator controller to know when screen state changes.
		 *  @param screenState Screen state on which the ad will be shown.
		 *  @param type Type of banner ad.
		 *  @param vAlign Vertical alignment of banner.
		 *  @param hAlign Horizontal alignment of banner. */		
		public function regScreenBanner(controller:ScreenNavigatorCtrl, screenState:String, type:String, vAlign:String, hAlign:String):void
		{
			if(AdMob.isSupported)
			{
				if(!_screens)
					_screens = new Dictionary();
					
				if(!_ctrlListenersAdded)
				{
					controller.addEventListener(ScreenNavigatorEvent.STATE_CHANGED, onScreenChanged);
					controller.addEventListener(ScreenNavigatorEvent.INITIALIZED, onScreenChanged);
					_ctrlListenersAdded = true;
				}
				
				if(_screens.hasOwnProperty(screenState))
				{
					_screens[screenState].banner = true;
					_screens[screenState].type = type;
					_screens[screenState].format.verticalAlign = vAlign;
					_screens[screenState].format.horizontalAlign = hAlign;
				}
				else
				{
					_screens[screenState] = new ScreenTracker(1, false, true, type, vAlign, hAlign);
				}
			}
		}
		
		/** Show ad on the screen.
		 *  @param onlyInterstitial Show only interstitial type of ad. */		
		protected function trackViewInternal(onlyInterstitial:Boolean):void
		{
			if(_tracker.interstitial && _tracker.count >= _tracker.pereiod && AdMob.isInterstitialReady())
			{
				_tracker.count = 0;
				AdMob.showPendingInterstitial();
				dispatchEvent(new AdEvent(AdEvent.INTERSTITIAL_SHOWED));
			}
			
			if(_tracker.banner && !onlyInterstitial)
			{
				try
				{
					AdMob.showAd(_tracker.type, _tracker.hAlign, _tracker.vAlign);
					AdMob.setVisibility(true);
				} 
				catch(e:Error){}
				
				dispatchEvent(new AdEvent(AdEvent.BANNER_SHOWED));
			}
		}
		
		/** @private */		
		private function onScreenChanged(e:ScreenNavigatorEvent):void
		{
			if(_screens.hasOwnProperty(e.state))
			{
				trackView(e.state);
			}
			else
			{
				if(_tracker && _tracker.banner)
				{
					try
					{
						AdMob.setVisibility(false);
					} 
					catch(e:Error){}
				}
				
				_tracker = null;
			}
		}
		
		/** @private */
		private function trackView(screenName:String):void
		{
			if(_tracker != _screens[screenName])
			{
				if(_tracker && _tracker.banner)
				{
					try
					{
						AdMob.setVisibility(false);
					} 
					catch(e:Error){}
				}
				
				_tracker = _screens[screenName];
				if(_tracker)
				{
					_tracker.count++;
					trackViewInternal(false);
				}
			}
		}
		
		/** @private */
		private function onReceiveAd(e:AdMobEvent):void
		{
			if(_tracker)
			{
				trackViewInternal(true);
			}
		}
		
		/** @private */
		private function onAdDismissed(e:AdMobEvent):void
		{
			if(_googleIntrestitialId)
				AdMob.loadInterstitial(_googleIntrestitialId, false, _iosIntrestitialId);
		}
		
		/** @private */
		private function onFailedReceiveAd(e:AdMobErrorEvent):void
		{
			trace(e.text)
		}
	}
}

/** Internal view object class for storing information about the screen state and type of ad to show. */
class ScreenTracker
{
	public var pereiod:int;
	public var count:int;
	public var interstitial:Boolean;
	public var banner:Boolean;
	public var vAlign:String;
	public var hAlign:String;
	public var type:String;
	
	public function ScreenTracker(pereiod:int, interstitial:Boolean = false, banner:Boolean = false, type:String="", vAlign:String="", hAlign:String="")
	{
		this.type = type;
		this.hAlign = hAlign;
		this.vAlign = vAlign;
		this.banner = banner;
		this.interstitial = interstitial;
		this.pereiod = pereiod;
	}
}


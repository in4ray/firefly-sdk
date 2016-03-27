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
	 *  @see https://www.milkmanplugins.com/admob-air-ane
	 */	
	public class AdManager extends EventDispatcher
	{
		private var _screens:Dictionary;
		
		private var tracker:ScreenTracker;

		private var _googleIntrestitialId:String;

		private var _iosIntrestitialId:String;

		private var _iosBannerId:String;

		private var _googleBannerId:String;
		
		private var _ctrlListenersAdded:Boolean;
		
		public function AdManager()
		{
			SingletonLocator.register(this, AdManager);
		}
		
		public static function get instance():AdManager {return SingletonLocator.getInstance(AdManager); }
		
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
			
			AdMob.init(googleIntrestitialId);
			AdMob.addEventListener(AdMobEvent.RECEIVED_AD, onReceiveAd);
			AdMob.addEventListener(AdMobEvent.SCREEN_DISMISSED, onAdDismissed);
			AdMob.addEventListener(AdMobErrorEvent.FAILED_TO_RECEIVE_AD, onFailedReceiveAd);
			
			if(devMode)
				AdMob.enableTestDeviceIDs(AdMob.getCurrentTestDeviceIDs());
			
			if(_googleIntrestitialId)
				AdMob.loadInterstitial(_googleIntrestitialId, false, _iosIntrestitialId);
		}
		
		
		
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
					_screens[screenState].vAlign = vAlign;
					_screens[screenState].hAlign = hAlign;
				}
				else
					_screens[screenState] = new ScreenTracker(1, false, true, type, vAlign, hAlign);
			}
		}
		
		private function onScreenChanged(e:ScreenNavigatorEvent):void
		{
			if(_screens.hasOwnProperty(e.state))
			{
				trackView(e.state);
			}
			else
			{
				if(tracker && tracker.banner)
				{
					try
					{
						AdMob.setVisibility(false);
					} 
					catch(e:Error){}
				}
				
				tracker = null;
			}
		}
		
		private function trackView(screenName:String):void
		{
			if(tracker != _screens[screenName])
			{
				if(tracker && tracker.banner)
				{
					try
					{
						AdMob.setVisibility(false);
					} 
					catch(e:Error){}
				}
				
				tracker = _screens[screenName];
				if(tracker)
				{
					tracker.count++;
					trackViewInternal(false);
				}
			}
		}
		
		private function onReceiveAd(e:AdMobEvent):void
		{
			if(tracker)
			{
				trackViewInternal(true);
			}
		}
		
		private function onAdDismissed(e:AdMobEvent):void
		{
			if(_googleIntrestitialId)
				AdMob.loadInterstitial(_googleIntrestitialId, false, _iosIntrestitialId);
		}
		
		private function onFailedReceiveAd(e:AdMobErrorEvent):void
		{
			trace(e.text)
		}
		
		protected function trackViewInternal(onlyInterstitial:Boolean):void
		{
			if(tracker.interstitial && tracker.count >= tracker.pereiod && AdMob.isInterstitialReady())
			{
				tracker.count = 0;
				AdMob.showPendingInterstitial();
				dispatchEvent(new AdEvent(AdEvent.INTERSTITIAL_SHOWED));
			}
			
			if(tracker.banner && !onlyInterstitial)
			{
				try
				{
					AdMob.showAd(tracker.type, tracker.hAlign, tracker.vAlign);
					AdMob.setVisibility(true);
				} 
				catch(e:Error){}
				
				dispatchEvent(new AdEvent(AdEvent.BANNER_SHOWED));
			}
		}
	}
}

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


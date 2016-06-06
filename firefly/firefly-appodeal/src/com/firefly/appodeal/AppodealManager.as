package com.firefly.appodeal
{
	import com.appodeal.aneplugin.Appodeal;
	import com.firefly.core.controllers.ScreenNavigatorCtrl;
	import com.firefly.core.events.ScreenNavigatorEvent;
	import com.firefly.core.utils.Log;
	import com.firefly.core.utils.SingletonLocator;
	
	import flash.utils.Dictionary;
	
	import starling.events.EventDispatcher;
	
	[Event(name="interstitialShowed", type="com.in4ray.appodeal.AdEvent")]
	[Event(name="bannerShowed", type="com.in4ray.appodeal.AdEvent")]
	[Event(name="skippableVideoShowed", type="com.in4ray.appodeal.AdEvent")]
	[Event(name="nonSkippableVideoShowed", type="com.in4ray.appodeal.AdEvent")]
	[Event(name="rewordedVideoShowed", type="com.in4ray.appodeal.AdEvent")]
	
	public class AppodealManager extends EventDispatcher
	{
		/** @private */		
		private var _screens:Dictionary;
		/** @private */
		private var _tracker:ScreenTracker;
		/** @private */
		private var _appodeal:Appodeal;
		/** @private */
		private var _appKey:String;
		/** @private */
		private var _adType:int;
		/** @private */
		private var _ctrlListenersAdded:Boolean;
		
		/** Constructor. */		
		public function AppodealManager()
		{
			SingletonLocator.register(this, AppodealManager);
		}
		
		public function init(appKey:String, adType:int):void
		{
			if(!Appodeal.isSupported)
				return;
			
			if(!appKey)
			{
				Log.error("App key ID is not set");
				return;
			}
			
			_appKey = appKey;
			_adType = adType;
			
			_appodeal = new Appodeal();
			_appodeal.initialize(_appKey, _adType);
		}
		
		/** Register screen state for showing interstitial ad on it. This type of ad will be shown when the 
		 *  game will switch to this screen state.
		 *  @param controller Screen navigator controller to know when screen state changes.
		 *  @param screenState Screen state on which the ad will be shown.
		 *  @param pereiod How often the ad will be shown for registered screen state.
		 *  @param firstShow Define to show the ad on first switching for registered screen state. */		
		public function regScreenInterstitial(controller:ScreenNavigatorCtrl, screenState:String, pereiod:int, firstShow:Boolean=false):void
		{
			if(_appodeal.isInited)
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
		 *  @param placement Vertical placement of ad banner. */		
		public function regScreenBanner(controller:ScreenNavigatorCtrl, screenState:String, placement:String):void
		{
			if(_appodeal.isInited)
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
					_screens[screenState].placement = placement;
				}
				else
				{
					_screens[screenState] = new ScreenTracker(1, false, true, placement);
				}
			}
		}
		
		/** @private */
		private function trackView(screenName:String):void
		{
			if(_tracker != _screens[screenName])
			{
				/*if(_tracker && _tracker.banner)
				{
				try
				{
				AdMob.setVisibility(false);
				} 
				catch(e:Error){}
				}*/
				
				_tracker = _screens[screenName];
				if(_tracker)
				{
					_tracker.count++;
					trackViewInternal(false);
				}
			}
		}
		
		/** Show ad on the screen.
		 *  @param onlyInterstitial Show only interstitial type of ad. */		
		protected function trackViewInternal(onlyInterstitial:Boolean):void
		{
			if(_tracker.interstitial && _tracker.count >= _tracker.pereiod && _appodeal.isLoaded(Appodeal.INTERSTITIAL))
			{
				_tracker.count = 0;
				_appodeal.show(Appodeal.INTERSTITIAL);
				dispatchEvent(new AppodealEvent(AppodealEvent.INTERSTITIAL_SHOWED));
			}
			
			if(_tracker.banner && !onlyInterstitial && _appodeal.isLoaded(Appodeal.BANNER))
			{
				try
				{
					_appodeal.showWithPlacement(Appodeal.BANNER, _tracker.placement);
					//AdMob.showAd(_tracker.type, _tracker.hAlign, _tracker.vAlign);
					//AdMob.setVisibility(true);
				} 
				catch(e:Error){}
				
				dispatchEvent(new AppodealEvent(AppodealEvent.BANNER_SHOWED));
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
				/*if(_tracker && _tracker.banner)
				{
				try
				{
				AdMob.setVisibility(false);
				} 
				catch(e:Error){}
				}*/
				
				_tracker = null;
			}
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
	public var placement:String;
	
	public function ScreenTracker(pereiod:int, interstitial:Boolean = false, banner:Boolean = false,placementtype:String="")
	{
		this.placement = placement;
		this.banner = banner;
		this.interstitial = interstitial;
		this.pereiod = pereiod;
	}
}
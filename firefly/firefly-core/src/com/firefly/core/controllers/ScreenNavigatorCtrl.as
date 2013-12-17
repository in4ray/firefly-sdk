package com.firefly.core.controllers
{
	import com.firefly.core.Firefly;
	import com.firefly.core.assets.AssetManager;
	import com.firefly.core.components.Splash;
	import com.firefly.core.controllers.helpers.ViewState;
	import com.firefly.core.display.IViewNavigator;
	import com.firefly.core.events.NavigationEvent;
	import com.firefly.core.utils.CacheableClassFactory;
	import com.firefly.core.utils.ClassFactory;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import starling.core.Starling;

	public class ScreenNavigatorCtrl extends ViewNavigatorCtrl
	{

		private var _assetManager:AssetManager;

		private var _splashClass:ClassFactory;
		
		
		public function ScreenNavigatorCtrl(viewNavigator:IViewNavigator, assetManager:AssetManager)
		{
			super(viewNavigator);
			_assetManager = assetManager;
			
			Firefly.current.main.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			Firefly.current.main.stage.addEventListener(Event.ACTIVATE, onActivate);
		}
		
		protected function onActivate(event:Event):void
		{
			navigateHandler(new NavigationEvent(NavigationEvent.ACTIVATE));
		}
		
		protected function onKeyUp(event:KeyboardEvent):void
		{
			if(_viewNavigator && event.keyCode == Keyboard.BACK)
				navigateHandler(new NavigationEvent(NavigationEvent.BACK));
		}
		
		public function regSplash(splashClass:Class, cache:Boolean=true):void
		{
			_splashClass = cache ? new CacheableClassFactory(splashClass) : new ClassFactory(splashClass);
		}
		
		public function regScreen(state:String, screenClass:Class, assetState:String, cache:Boolean=true):void
		{
			var factory:ClassFactory = cache ? new CacheableClassFactory(screenClass) : new ClassFactory(screenClass);
			_views[state] = new ViewState(state, factory, assetState);
		}
		
		override public function navigate(toState:String, data:Object=null):void
		{
			removeCurrentView();
			_assetManager.switchToStateName(_views[toState].assetState).then(navigateInternal, toState, data);
		}
		
		private function navigateInternal(toState:String, data:Object=null):void
		{
			super.navigate(toState, data);
		}
		
		public function start(state:String):void
		{
			var splash:Splash;
			if(_splashClass)
			{
				splash = _splashClass.newInstance();
				splash.width = Firefly.current.stageWidth;
				splash.height = Firefly.current.stageHeight;
				Starling.current.nativeOverlay.addChild(splash);
			}
			
			_assetManager.switchToStateName(_views[state].assetState).then(onLoaded, splash, state);
		}
		
		private function onLoaded(splash:Splash, state:String):void
		{
			if(splash)
				Starling.current.nativeOverlay.removeChild(splash);
			
			navigateInternal(state);
		}
	}
}
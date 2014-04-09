package com.firefly.core.controllers
{
	import com.firefly.core.Firefly;
	import com.firefly.core.assets.AssetManager;
	import com.firefly.core.components.Splash;
	import com.firefly.core.controllers.helpers.ViewState;
	import com.firefly.core.display.IViewNavigator;
	import com.firefly.core.events.NavigationEvent;
	import com.firefly.core.transitions.ITransition;
	import com.firefly.core.utils.ClassFactory;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import starling.core.Starling;

	public class ScreenNavigatorCtrl
	{
		private var _splashClass:ClassFactory;
		
		private var _navigator:ViewNavigatorCtrl;

		private var _viewNavigator:IViewNavigator;
		
		public function ScreenNavigatorCtrl(viewNavigator:IViewNavigator, assetManager:AssetManager)
		{
			_viewNavigator = viewNavigator;
			_navigator = new ViewNavigatorCtrl(viewNavigator, assetManager);
			
			Firefly.current.main.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			Firefly.current.main.stage.addEventListener(flash.events.Event.ACTIVATE, onActivate);
		}
		
		public function regNavigation(trigger:String, fromState:String, toState:String, transition:ITransition = null):void
		{
			_navigator.regNavigation(trigger, fromState, toState, transition);			
		}
		
		protected function onActivate(event:flash.events.Event):void
		{
			_navigator.navigate(NavigationEvent.ACTIVATE);
		}
		
		protected function onKeyUp(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.BACK)
				navigate(NavigationEvent.BACK);
		}
		
		public function regSplash(splashClass:Class):void
		{
			_splashClass = new ClassFactory(splashClass);
		}
		
		public function regScreen(state:String, screenClass:Class, assetState:String, cache:Boolean=true):void
		{
			_navigator.regState(new ViewState(state, new ClassFactory(screenClass), assetState, cache));
		}
		
		public function navigate(trigger:String, data:Object=null):void
		{
			_navigator.navigate(trigger, data);
		}
		
		public function navigateToState(toState:String, data:Object=null):void
		{
			_navigator.navigateToState(toState, data);
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
			
			var viewState:ViewState = _navigator.getState(state);
			if(viewState)
				_navigator.assetManager.switchToStateName(viewState.assetState).then(onLoaded, splash, state);
		}
		
		private function onLoaded(splash:Splash, state:String):void
		{
			if(splash)
				Starling.current.nativeOverlay.removeChild(splash);
			
			_navigator.navigateToState(state);
		}
	}
}
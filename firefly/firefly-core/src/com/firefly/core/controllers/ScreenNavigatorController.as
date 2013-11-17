package com.firefly.core.controllers
{
	import com.firefly.core.Firefly;
	import com.firefly.core.assets.AssetManager;
	import com.firefly.core.components.Splash;
	import com.firefly.core.controllers.helpers.ViewState;
	import com.firefly.core.display.IViewNavigator;
	import com.firefly.core.utils.ClassFactory;
	
	import starling.core.Starling;

	public class ScreenNavigatorController extends ViewNavigatorController
	{

		private var _assetManager:AssetManager;

		private var _splashClass:ClassFactory;
		
		
		public function ScreenNavigatorController(viewNavigator:IViewNavigator, assetManager:AssetManager)
		{
			super(viewNavigator);
			_assetManager = assetManager;
		}
		
		public function regSplash(splashClass:ClassFactory):void
		{
			_splashClass = splashClass;
		}
		
		public function regScreen(state:String, factory:ClassFactory, assetState:String):void
		{
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
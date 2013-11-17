package com.firefly.core.components
{
	import com.firefly.core.assets.AssetManager;
	import com.firefly.core.controllers.ScreenNavigatorController;
	import com.firefly.core.display.INavigationView;
	import com.firefly.core.display.IViewNavigator;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	
	public class ScreenNavigator extends Sprite implements IViewNavigator
	{
		private var _assetManager:AssetManager;
		
		private var _controller:ScreenNavigatorController;
		
		public function ScreenNavigator()
		{
			super();
			
			_assetManager = new AssetManager();
			
			_controller = new ScreenNavigatorController(this, _assetManager);
		}
		
		public function get assetManager():AssetManager { return _assetManager; }
		public function get controller():ScreenNavigatorController { return _controller; }
		public function addView(view:INavigationView):void { addChild(view as DisplayObject); }
		public function removeView(view:INavigationView):void { removeChild(view as DisplayObject);	}
	}
}
package com.firefly.core.components
{
	import com.firefly.core.assets.AssetManager;
	import com.firefly.core.controllers.ScreenNavigatorCtrl;
	import com.firefly.core.display.INavigationView;
	import com.firefly.core.display.IViewNavigator;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	
	public class ScreenNavigator extends Sprite implements IViewNavigator
	{
		private var _assetManager:AssetManager;
		
		private var _controller:ScreenNavigatorCtrl;
		
		public function ScreenNavigator()
		{
			super();
			
			_assetManager = new AssetManager();
			
			_controller = new ScreenNavigatorCtrl(this, _assetManager);
		}
		
		public function get assetManager():AssetManager { return _assetManager; }
		public function get controller():ScreenNavigatorCtrl { return _controller; }
		public function addView(view:INavigationView):void { addChild(view as DisplayObject); }
		public function removeView(view:INavigationView):void { removeChild(view as DisplayObject);	}
	}
}
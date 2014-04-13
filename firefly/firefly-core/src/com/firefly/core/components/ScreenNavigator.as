package com.firefly.core.components
{
	import com.firefly.core.Firefly;
	import com.firefly.core.assets.AssetManager;
	import com.firefly.core.controllers.ScreenNavigatorCtrl;
	import com.firefly.core.display.IView;
	import com.firefly.core.display.IViewNavigator;
	import com.firefly.core.layouts.Layout;
	import com.firefly.core.layouts.constraints.$height;
	import com.firefly.core.layouts.constraints.$width;
	
	import starling.display.DisplayObject;
	
	public class ScreenNavigator extends View implements IViewNavigator
	{
		private var _assetManager:AssetManager;
		
		private var _controller:ScreenNavigatorCtrl;
		
		private var _layout:Layout;
		
		public function ScreenNavigator()
		{
			super();
			
			_layout = new Layout(this);
			
			_assetManager = new AssetManager();
			
			_controller = new ScreenNavigatorCtrl(this, _assetManager);
			
			width = Firefly.current.stageWidth;
			height = Firefly.current.stageHeight;
		}
		
		public function get assetManager():AssetManager { return _assetManager; }
		public function get controller():ScreenNavigatorCtrl { return _controller; }
		public function removeView(view:IView):void { removeChild(view as DisplayObject);	}
		
		public function addView(view:IView, index:int=-1):void 
		{
			if(index > -1)
				_layout.addElementAt(view as DisplayObject, index, $width(100).pct, $height(100).pct);
			else
				_layout.addElement(view as DisplayObject, $width(100).pct, $height(100).pct); 
		}
		
		public function getViewIndex(view:IView):int
		{
			return getChildIndex(view as DisplayObject);
		}
	}
}
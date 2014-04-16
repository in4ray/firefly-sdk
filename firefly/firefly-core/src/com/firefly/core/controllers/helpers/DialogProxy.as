package com.firefly.core.controllers.helpers
{
	import com.firefly.core.display.INavigator;
	import com.firefly.core.display.IScreenNavigator;
	import com.firefly.core.display.IView;

	public class DialogProxy implements INavigator
	{
		private var _navigator:IScreenNavigator;
		
		public function DialogProxy(navigator:IScreenNavigator)
		{
			_navigator = navigator;
		}
		
		public function addEventListener(type:String, listener:Function):void
		{
			_navigator.addEventListener(type, listener);
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return _navigator.hasEventListener(type);
		}
		
		public function addView(view:IView, index:int=-1):void
		{
			_navigator.addDialog(view);
		}
		
		public function removeView(view:IView):void
		{
			_navigator.removeView(view);
		}
		
	}
}
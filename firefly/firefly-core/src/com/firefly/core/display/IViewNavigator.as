package com.firefly.core.display
{
	public interface IViewNavigator
	{
		function addEventListener(type:String, listener:Function):void;
		function addView(view:INavigationView):void
		function removeView(view:INavigationView):void
	}
}
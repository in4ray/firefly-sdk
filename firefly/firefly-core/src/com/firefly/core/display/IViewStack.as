package com.firefly.core.display
{
	public interface IViewStack
	{
		function addView(view:IView):void
		function removeView(view:IView):void
	}
}
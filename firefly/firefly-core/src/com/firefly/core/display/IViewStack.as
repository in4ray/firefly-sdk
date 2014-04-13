package com.firefly.core.display
{
	public interface IViewStack
	{
		function addView(view:IView, index:int=-1):void
		function getViewIndex(view:IView):int
		function removeView(view:IView):void
	}
}
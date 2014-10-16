package com.firefly.core.display
{
	import com.firefly.core.controllers.VScrollerCtrl;

	public interface IVScrollerContainer extends IScroller
	{
		function get height():Number;
		function get vScrollerCtrl():VScrollerCtrl;
	}
}
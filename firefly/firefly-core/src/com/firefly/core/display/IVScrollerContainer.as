package com.firefly.core.display
{
	import com.firefly.core.controllers.VScrollerCtrl;

	public interface IVScrollerContainer
	{
		function get y():Number;
		function get height():Number;
		function get vScrollerCtrl():VScrollerCtrl;
		
		function updateY(dy:Number):void;
	}
}
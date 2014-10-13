package com.firefly.core.display
{
	import com.firefly.core.controllers.HScrollerCtrl;

	public interface IHScrollerContainer
	{
		function get x():Number;
		function get width():Number;
		function get hScrollerCtrl():HScrollerCtrl;
		
		function updateX(dx:Number):void;
	}
}
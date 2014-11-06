package com.firefly.core.display
{
	public interface IHScrollBar
	{
		function get width():Number;
		function get height():Number;
		function get thumbWidth():Number;
		function set thumbX(value:Number):void;
		function set visible(value:Boolean):void;
	}
}
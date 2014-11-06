package com.firefly.core.display
{
	public interface IVScrollBar
	{
		function get width():Number;
		function get height():Number;
		function get thumbHeight():Number;
		function set thumbY(value:Number):void;
		function set visible(value:Boolean):void;
	}
}
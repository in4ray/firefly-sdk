package com.firefly.core.display
{
	public interface IViewport extends ILayoutComponent
	{
		function get id():String;
		function set id(value:String):void;
		function get x():Number;
		function set x(value:Number):void;
		function get y():Number;
		function set y(value:Number):void;
		function get width():Number;
		function set width(value:Number):void;
		function get height():Number;
		function set height(value:Number):void;
		function get hFraction():Number;
		function set hFraction(value:Number):void;
		function get vFraction():Number;
		function set vFraction(value:Number):void;
	}
}
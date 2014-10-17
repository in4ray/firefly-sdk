package com.firefly.core.display
{
	public interface IViewport
	{
		function get id():String;
		function set id(val:String):void;
		function get x():Number;
		function set x(val:Number):void;
		function get y():Number;
		function set y(val:Number):void;
		function get width():Number;
		function set width(val:Number):void;
		function get height():Number;
		function set height(val:Number):void;
		function get moveMultiplier():Number;
		function set moveMultiplier(val:Number):void;
	}
}
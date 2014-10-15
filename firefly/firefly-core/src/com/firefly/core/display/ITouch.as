package com.firefly.core.display
{
	public interface ITouch
	{
		function get x():Number;
		function set x(val:Number):void;
		function get y():Number;
		function set y(val:Number):void;
		function get phaseType():String;
		function set phaseType(val:String):void;
		
		function clone():ITouch;
	}
}
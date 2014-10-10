package com.firefly.core.display
{
	import flash.geom.Rectangle;

	public interface IScroller
	{
		function addEventListener(type:String, listener:Function):void;
		function removeEventListener(type:String, listener:Function):void;
		function hasEventListener(type:String):Boolean;
	}
}
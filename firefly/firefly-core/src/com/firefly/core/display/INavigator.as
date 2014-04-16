package com.firefly.core.display
{
	public interface INavigator extends IViewStack
	{
		function addEventListener(type:String, listener:Function):void;
		function hasEventListener(type:String):Boolean;
	}
}
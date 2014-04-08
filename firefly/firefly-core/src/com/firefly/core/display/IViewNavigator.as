package com.firefly.core.display
{
	public interface IViewNavigator extends IViewStack
	{
		function addEventListener(type:String, listener:Function):void;
	}
}
package com.firefly.core.display
{
	public interface IScreen extends IView
	{
		function startShowTransition():void
		function startHideTransition():void
	}
}
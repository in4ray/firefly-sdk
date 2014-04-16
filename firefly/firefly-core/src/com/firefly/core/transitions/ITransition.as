package com.firefly.core.transitions
{
	import com.firefly.core.controllers.NavigatorCtrl;
	import com.firefly.core.controllers.helpers.ViewState;

	public interface ITransition
	{
		function transit(navigator:NavigatorCtrl, toState:ViewState, data:Object=null):void;
	}
}
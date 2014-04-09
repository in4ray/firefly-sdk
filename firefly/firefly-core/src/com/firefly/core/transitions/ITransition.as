package com.firefly.core.transitions
{
	import com.firefly.core.controllers.ViewNavigatorCtrl;
	import com.firefly.core.controllers.helpers.ViewState;

	public interface ITransition
	{
		function transit(toState:ViewState, data:Object=null):void;
		function set navigator(value:ViewNavigatorCtrl):void;
		function get navigator():ViewNavigatorCtrl;
	}
}
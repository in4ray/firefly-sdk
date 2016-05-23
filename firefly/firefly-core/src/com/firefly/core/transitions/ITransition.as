// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.transitions
{
	import com.firefly.core.controllers.NavigatorCtrl;
	import com.firefly.core.controllers.helpers.ViewState;

	/** The interface for all transition effects. */
	public interface ITransition
	{
		/** Start the transition between view states.
		 *  @param navigator Instance of navigator controller.
		 *  @param toState Which state the transition occurs.
		 *  @param data Data which will put to the screen after transition. */		
		function transit(navigator:NavigatorCtrl, toState:ViewState, data:Object=null):void;
	}
}
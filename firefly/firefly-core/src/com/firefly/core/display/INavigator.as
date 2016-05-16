// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.display
{
	/** An interface should be implemented by ui classes which can be managed by <code>NavigatorCtrl</code> for 
	 *  organizing transitions, switching between view components added to the navigator component.  */
	public interface INavigator extends IViewStack
	{
		/** Registers an event listener at a certain object.
		 *  @param type Event type.
		 *  @param listener Function which be called when event was invoked. */		
		function addEventListener(type:String, listener:Function):void;
		
		/** If called with one argument, figures out if there are any listeners registered for the given event 
		 *  type. If called with two arguments, also determines if a specific listener is registered.
		 *  @param type Event type.
		 *  @param listener Function which be called when event was invoked. */		
		function hasEventListener(type:String, listener:Function=null):Boolean;
	}
}
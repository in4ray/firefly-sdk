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
	/** An interface should be implemented by dialogs which can be registered and added to the 
	 *  <code>ScreenNavigator</code> container. */
	public interface IDialog extends IView
	{
		/** This function calls where dialog is opened and back button was invoked. */		
		function onBack():void;
		
		/** Set current screen */		
		function set screen(v:IScreen):void;
	}
}
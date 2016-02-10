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
	/** An interface should be implemented by classes which can be added to screen navigator component
	 *  for notification about different statuses in the screen. */
	public interface IScreen extends IView
	{
		/** This function automatically invokes by screen navigator controller etc. 
		 *  in case a dialog appeared in the concrete screen.
		 *  @param dialog Instance of the dialog which appeared in the screen. */	
//		/function dialogAppeared(dialog:IDialog):void;
		
		function activate():void;
		
		function deactivate():void;
	}
}
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
	/** An interface should be implemented by ui classes which can be added to the screen navigator component
	 *  for notification about different statuses in the screen. */
	public interface IScreen extends IView
	{
		/** This function calls in case all dialogs, views have hided from the current screen where these 
		 *  additional components were added. */		
		function activate():void;
		
		/** This function calls in case dialog or view displayed on the screen.*/
		function deactivate():void;
	}
}
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
	/** An interface should be implemented by ui classes which can be managed by <code>ScreenNavigatorCtrl</code> 
	 *  for organizing transitions, switching between screens and dialogs added to the screen navigator component. */
	public interface IScreenNavigator extends INavigator
	{
		/** This function adds dialog to the screen navigator.
		 *  @param dailog Instance of the dialog. */		
		function addDialog(dialog:IDialog):void;
	}
}
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
	/** An interface should be implemented by classes which can be added to view stack component 
	 *  for notification about different statuses in the view. */
	public interface IView
	{
		/** Specific data which can be used to set data to the view. This function invokes
		 *  before calling <code>show()</code> function. */		
		function set viewData(data:Object):void;
		
		/** This function automatically invokes by view stack, screen navigator controllers etc. 
		 *  in case view component added to the stage.
		 *  @param data Specific data which can be used when view component shows. */		
		function show():void
			
		/** This function automatically invokes by view stack, screen navigator controllers etc.
		 * in case view component removed from the stage.*/		
		function hide():void
	}
}
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
	/** An interface should be implemented by classes which can be managed by <code>ViewStackCtrl</code> for 
	 *  switching between view components added to the view stack component.  */
	public interface IViewStack
	{
		/** This function adds view component to the view stack container.
		 *  @param view Instance of view component.
		 *  @param index Position index of the component in th stack. */		
		function addView(view:IView, index:int=-1):void;
		
		/** This function removes view component from the view stack container.
		 *  @param view Instance of view component.*/		
		function removeView(view:IView):void;
	}
}
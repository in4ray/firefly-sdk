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
	import com.firefly.core.layouts.Layout;

	/** An interface should be implemented by ui classes which place their children using 
	 *  <code>Layout</code> class.
	 *  @see com.firefly.core.layouts.Layout */
	public interface ILayoutComponent
	{
		/** Instance of the layout class. You can use this class if you want place children
		 *  in the component by specific rules.*/		
		function get layout():Layout;
		
		/** This function updates all children to the initial position, rotation values they were 
		 *  added using layout instance. All children which were added without using layout 
		 *  instance will not be updated. */		
		function updateLayout():void;
	}
}
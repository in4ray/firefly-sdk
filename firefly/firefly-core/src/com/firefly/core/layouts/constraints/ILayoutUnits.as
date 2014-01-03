// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.layouts.constraints
{
	/** Inaterface for layouts that uses measure units. */	
	public interface ILayoutUnits
	{
		/** Sets pixels units. */		
		function get px():LayoutConstraint;
		
		/** Sets context pixels units. */		
		function get cpx():LayoutConstraint;
		
		/** Sets percents units. */
		function get pct():LayoutConstraint;
		
		/** Sets inches units.*/
		function get inch():LayoutConstraint;
	}
}
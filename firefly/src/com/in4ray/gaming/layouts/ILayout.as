// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.layouts
{
	import com.in4ray.gaming.layouts.context.ILayoutContext;

	/**
	 * Interface for layout constraints. 
	 */	
	public interface ILayout
	{
		/**
		 * Do layout.
		 *  
		 * @param context Layout context.
		 * @param target Target of layout.
		 * @param targetContext Context target of layout.
		 */		
		function layout(context:ILayoutContext, target:LayoutTarget, targetContext:ILayoutContext):void;
		
		/**
		 * Get order of layout constrains for processing. 
		 * Lower value will be processed first.
		 * 
		 * @see com.in4ray.games.core.consts.LayoutOrder
		 */		
		function getOrder():uint;
		
		/**
		 * Layout constraint value.
		 */				
		function get value():Number;
		function set value(value:Number):void;
		
		/**
		 * Layout constraint measure units.
		 * 
		 * @see com.in4ray.games.core.consts.LayoutUnits
		 */		
		function getUnits():String;
		
		/**
		 * Global function that creates this constraint, e.g $x, $width, $bottom, etc.
		 *  
		 * @return global function.
		 */		
		function getGlobalFunc():Function;
	}
}
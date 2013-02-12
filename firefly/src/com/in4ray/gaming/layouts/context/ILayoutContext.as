// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.layouts.context
{
	import com.in4ray.gaming.components.IVisualContainer;
	import com.in4ray.gaming.layouts.ILayout;

	/**
	 * Interface for layout context. 
	 */	
	public interface ILayoutContext
	{
		/**
		 * Convert x value. 
		 * 
		 * @param layout Layout constraint.
		 * @return Value converted by context.
		 */		
		function getValueX(layout:ILayout):Number;
		
		/**
		 * Convert y value. 
		 * 
		 * @param layout Layout constraint.
		 * @return Value converted by context.
		 */	
		function getValueY(layout:ILayout):Number;
		
		/**
		 * Convert width value. 
		 * 
		 * @param layout Layout constraint.
		 * @return Value converted by context.
		 */	
		function getValueWidth(layout:ILayout):Number;
		
		/**
		 * Convert height value. 
		 * 
		 * @param layout Layout constraint.
		 * @return Value converted by context.
		 */	
		function getValueHeight(layout:ILayout):Number;
		
		/**
		 * Container height. 
		 */	
		function get height():Number;
		
		/**
		 * Container width. 
		 */	
		function get width():Number;
		
		/**
		 * Layout container. 
		 */		
		function get host():IVisualContainer;
	}
}
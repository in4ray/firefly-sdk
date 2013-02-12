// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.components
{
	import com.in4ray.gaming.layouts.$height;
	import com.in4ray.gaming.layouts.$width;
	import com.in4ray.gaming.layouts.$x;
	import com.in4ray.gaming.layouts.$y;
	import com.in4ray.gaming.layouts.context.ILayoutContext;

	/**
	 * Interface for all visual element containers both Flash and Starling. 
	 */	
	public interface IVisualContainer extends IVisualElement
	{
		function set layoutContext(value:ILayoutContext):void
			
		/**
		 * Layout context object. 
		 */			
		function get layoutContext():ILayoutContext; 
		
		/**
		 * Do layout for all children. 
		 */		
		function layoutChildren():void;
		
		/**
		 * Add visual element as a child. 
		 * 
		 * @param element Visual element component, it will be layouted after adding.
		 * @param layouts Layout constrains.
		 * 
		 * 
		 * @example The following example shows how to add layouts:
		 *
	 	 * <listing version="3.0">
addElement(new Quad(), $x(10).px, $y(20).px, $width(50).pct, $height(50).pct);
		 * </listing>
		 */		
		function addElement(element:IVisualElement, ...layouts):void
			
		/**
		 * Add visual element as a child at specified depth. 
		 * 
		 * @param element Visual element component, it will be layouted after adding.
		 * @param layouts Layout constrains.
		 */	
		function addElementAt(element:IVisualElement, index:int, ...layouts):void
			
		/**
		 * Remove child element.
		 *  
		 * @param element Visual element component.
		 * @return Visual element component.
		 */			
		function removeElement(element:IVisualElement):IVisualElement
			
		/**
		 * Remove child element by index.
		 *  
		 * @param index Index of element.
		 * @return Visual element component.
		 */	
		function removeElementAt(index:int):IVisualElement
			
		/**
		 * Number of children. 
		 * 
		 * @return Count of visual elements that contains container.
		 */			
		function get numChildren():int
	}
}
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
	import com.in4ray.gaming.layouts.ILayout;
	import com.in4ray.gaming.layouts.ILayoutManager;
	import com.in4ray.gaming.layouts.context.ILayoutContext;

	/**
	 * Interface for all visual elements both Flash and Starling. 
	 */	
	public interface IVisualElement
	{
		/**
		 * Do layout of this component. 
		 */	
		function layout():void
			
		/**
		 * Add layout constraint. 
		 * 
		 * @param layouts Layout constraint e.g. $left, $bottom, $width, $x etc.
		 * @return Layout manager object.
		 */	
		function addLayout(...layouts):ILayoutManager;
		
		/**
		 * Remove layout constraint.
		 *  
		 * @param layoutFunc Layout function e.g. $bottom
		 * @return Layout manager object.
		 */	
		function removeLayout(layout:Function):ILayoutManager;
		
		/**
		 * Get list of layout objects.
		 *  
		 * @return Vector of layouts
		 */	
		function getLayouts():Vector.<ILayout>;
		
		/**
		 * Get layout constraint.
		 * 
		 * @param layoutFunc Layout function e.g. $bottom
		 * @return Layout constraint
		 */		
		function getLayout(layoutFunc:Function):ILayout
			
		/**
		 * Add or update layout value and units.
		 *  
		 * @param layoutFunc Layout function e.g. $bottom
		 * @param value Layout value.
		 * @param units Layout units.
		 */
		function setLayoutValue(layoutFunc:Function, value:Number, units:String = null):void
			
		/**
		 * Layout context of parent container.
		 *  
		 * @return Layout context object
		 */	
		function get parentContext():ILayoutContext;
		
		/**
		 * Position in pixels by X-axis. 
		 */	
		function get x():Number;
		
		/**
		 * Position in pixels by Y-axis. 
		 */	
		function get y():Number;
		
		/**
		 * Width in pixels. 
		 */	
		function get width():Number;
		
		/**
		 * Height in pixels. 
		 */	
		function get height():Number;
		
		/**
		 * Set position of image bypassing layouts.
		 *  
		 * @param x Position in pixels by X axis.
		 * @param y Position in pixels by Y axis.
		 */
		function setActualSize(w:Number, h:Number):void;
		
		/**
		 * Set size of image bypassing layouts.
		 * 
		 * @param w Width in pixels.
		 * @param h Height in pixels.
		 */	
		function setActualPosition(x:Number, y:Number):void;
		
		/**
		 * Rotation in deg. 
		 */	
		function get rotation():Number;
		
		/**
		 * Rotation in deg. 
		 */	
		function set rotation(value:Number):void;
	}
}
// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.layouts.templates
{
	import com.in4ray.gaming.components.IVisualElement;
	import com.in4ray.gaming.layouts.ILayout;
	import com.in4ray.gaming.layouts.ILayoutManager;
	import com.in4ray.gaming.layouts.context.ILayoutContext;
	
	/**
	 * Place holder for visual objet that will be positioned by template.  
	 */	
	public class PlaceHolder implements IVisualElement
	{
		/**
		 * Constructor. 
		 */		 
		public function PlaceHolder()
		{
		}
		
		/**
		 * This function does nothing.
		 */		
		public function layout():void
		{
		}
		
		public var layouts:Array = new Array();
		
		/**
		 * @inheritDoc 
		 */		
		public function addLayout(...layouts):ILayoutManager
		{
			this.layouts = this.layouts.concat(layouts);
			return null;
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function removeLayout(layout:Function):ILayoutManager
		{
			return null;
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function getLayouts():Vector.<ILayout>
		{
			return null;
		}
		
		/**
		 * Get array of layouts. 
		 */		
		public function getLayoutArray():Array
		{
			return layouts;
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function getLayout(layoutFunc:Function):ILayout
		{
			return null;
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function setLayoutValue(layoutFunc:Function, value:Number, units:String = null):void
		{
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function get parentContext():ILayoutContext
		{
			return null;
		}
		
		public function set x(value:Number):void
		{
		}
		
		/**
		 * Just returns 0.
		 */	
		public function get x():Number
		{
			return 0;
		}
		
		public function set y(value:Number):void
		{
		}
		
		/**
		 * Just returns 0.
		 */		
		public function get y():Number
		{
			return 0;
		}
		
		/**
		 * Just returns 0.
		 */	
		public function get width():Number
		{
			return 0;
		}
		
		/**
		 * Just returns 0.
		 */	
		public function get height():Number
		{
			return 0;
		}
		
		/**
		 * Just returns 0.
		 */
		public function get rotation():Number
		{
			return 0;
		}
		
		public function set rotation(value:Number):void
		{
		}
		
		/**
		 * This function does nothing.
		 */		
		public function setActualSize(w:Number, h:Number):void
		{
		}
		
		/**
		 * This function does nothing.
		 */	
		public function setActualPosition(x:Number, y:Number):void
		{
		}
	}
}
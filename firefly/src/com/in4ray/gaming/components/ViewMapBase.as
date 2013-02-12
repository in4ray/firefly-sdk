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
	import com.in4ray.gaming.layouts.context.MapLayoutContext;
	
	import flash.geom.Rectangle;

	/**
	 * Basic component for view maps. 
	 */	
	public class ViewMapBase extends Sprite implements IViewMap
	{
		/**
		 * Constructor. 
		 */		
		public function ViewMapBase()
		{
			super();
			
			layoutContext = new MapLayoutContext(this);
		}
		
		protected var _mapWidth:Number;
		
		/**
		 * General map width in pixels. 
		 */		
		public function get mapWidth():Number
		{
			return !isNaN(_mapWidth) ? _mapWidth : contentBounds.right;
		}
		
		public function set mapWidth(value:Number):void
		{
			_mapWidth = value;
		}
		
		protected var _mapHeight:Number;
		
		/**
		 * General map height in pixels. 
		 */		
		public function get mapHeight():Number
		{
			return !isNaN(_mapHeight) ? _mapHeight : contentBounds.bottom;
		}
		
		public function set mapHeight(value:Number):void
		{
			_mapHeight = value;
		}
		
		protected var _viewPortX:Number = 0;
		
		/**
		 * Current view port position by X-axis. 
		 */	
		public function get viewPortX():Number
		{
			return Math.floor(_viewPortX);
		}
		
		public function set viewPortX(value:Number):void
		{
			_viewPortX = value;
			
			layoutChildren();
		}
		
		protected var _viewPortY:Number = 0;
		
		/**
		 * Current view port position by Y-axis. 
		 */	
		public function get viewPortY():Number
		{
			return Math.floor(_viewPortY);
		}
		
		public function set viewPortY(value:Number):void
		{
			_viewPortY = value;
			layoutChildren();
		}
		
		/**
		 * @private 
		 */		
		protected var contentBounds:Rectangle;
		
		/**
		 * @inheritDoc 
		 */		
		override public function setActualSize(w:Number, h:Number):void
		{
			super.setActualSize(w, h);
			contentBounds = bounds.clone();
		}
		
		/**
		 * @inheritDoc 
		 */
		override public function addElement(element:IVisualElement, ...layouts):void
		{
			super.addElement.apply(null, [element].concat(layouts));
			contentBounds = bounds.clone();
		}
		
		/**
		 * @inheritDoc 
		 */
		override public function addElementAt(element:IVisualElement, index:int, ...layouts):void
		{
			super.addElementAt.apply(null, [element, index].concat(layouts));
			contentBounds = bounds.clone();
		}
	}
}
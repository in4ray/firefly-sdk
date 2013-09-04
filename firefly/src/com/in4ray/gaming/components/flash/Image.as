// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.components.flash
{
	import com.in4ray.gaming.components.IVisualContainer;
	import com.in4ray.gaming.components.IVisualElement;
	import com.in4ray.gaming.layouts.ILayout;
	import com.in4ray.gaming.layouts.ILayoutManager;
	import com.in4ray.gaming.layouts.LayoutManager;
	import com.in4ray.gaming.layouts.context.ILayoutContext;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	/**
	 * Flash image class used in most cases for splash screens. 
	 */	
	public class Image extends Bitmap implements IVisualElement
	{
		/**
		 * Initializes a Bitmap object to refer to the specified BitmapData object.
		 * 
		 * @param bitmapData The BitmapData object being referenced.
		 * @param pixelSnapping Whether or not the Bitmap object is snapped to the nearest pixel.
		 * @param smoothing Whether or not the bitmap is smoothed when scaled. 
		 * 
		 */		
		public function Image(bitmapData:BitmapData=null, pixelSnapping:String="auto", smoothing:Boolean=false)
		{
			super(bitmapData, pixelSnapping, smoothing);
			
			layoutManager = new LayoutManager(this);
		}
		
		/**
		 * Layout manager object. 
		 */		
		protected var layoutManager:LayoutManager;
		
		/**
		 * @inheritDoc
		 */		
		public function addLayout(...layouts):ILayoutManager
		{
			layoutManager.addLayouts(layouts);
			return layoutManager;
		}
		
		/**
		 * @inheritDoc
		 */		
		public function removeLayout(layoutFunc:Function):ILayoutManager
		{
			layoutManager.removeLayout(layoutFunc)
			return layoutManager;
		}
		
		/**
		 * @inheritDoc
		 */		
		public function getLayouts():Vector.<ILayout>
		{
			return layoutManager.getLayouts();
		}
		
		/**
		 * @inheritDoc
		 */			
		public function getLayout(layoutFunc:Function):ILayout
		{
			return layoutManager.getLayout(layoutFunc);
		}
		
		/**
		 * @inheritDoc
		 */		
		public function layout():void
		{
			layoutManager.layout();
		}
		
		/**
		 * @inheritDoc
		 */		
		public function setLayoutValue(layoutFunc:Function, value:Number, units:String = null):void
		{
			layoutManager.setLayoutValue(layoutFunc, value, units);
		}
		
		/**
		 * @inheritDoc
		 */		
		public function get parentContext():ILayoutContext
		{
			return parent ? (parent as IVisualContainer).layoutContext : null;
		}
		
		override public function set x(value:Number):void
		{
			throw Error("Forbidden, use layouts");
		}
		
		override public function set y(value:Number):void
		{
			throw Error("Forbidden, use layouts");
		}
		
		override public function set width(value:Number):void
		{
			throw Error("Forbidden, use layouts");
		}
		
		override public function set height(value:Number):void
		{
			throw Error("Forbidden, use layouts");
		}
		
		/**
		 * @inheritDoc
		 */		
		public function setActualPosition(x:Number, y:Number):void
		{
			if(!isNaN(x))
				super.x = x;
			if(!isNaN(y))
				super.y = y;
		}
		
		/**
		 * @inheritDoc
		 */	
		public function setActualSize(w:Number, h:Number):void
		{
			if(!isNaN(w))
				super.width = w;
			if(!isNaN(h))
				super.height = h;
		}
		
		/**
		 * @inheritDoc
		 */	
		public function get pivotX():Number
		{
			return 0;
		}
		
		/**
		 * @inheritDoc
		 */	
		public function get pivotY():Number
		{
			return 0;
		}
		
		/**
		 * @inheritDoc
		 */	
		public function setActualPivots(px:Number, py:Number):void
		{
			if(!isNaN(px) || !isNaN(py))
				throw Error("Flash based components don't support pivots.");
		}
	}
}


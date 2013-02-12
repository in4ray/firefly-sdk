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
	
	import flash.text.TextField;
	
	/**
	 * Flash text field class used in most cases for splash screens. 
	 */	
	public class TextField extends flash.text.TextField implements IVisualElement
	{
		/**
		 * Constructor. 
		 */		
		public function TextField()
		{
			super();
			
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
		public function setLayoutValue(layoutFunc:Function, value:Number, units:String = null):void
		{
			layoutManager.setLayoutValue(layoutFunc, value, units);
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
	}
}

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
	import com.in4ray.gaming.events.BindingEvent;
	import com.in4ray.gaming.layouts.ILayout;
	import com.in4ray.gaming.layouts.ILayoutManager;
	import com.in4ray.gaming.layouts.LayoutManager;
	import com.in4ray.gaming.layouts.context.ILayoutContext;
	import com.in4ray.gaming.locale.LocaleManager;
	
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
			
			lm = LocaleManager.getInstance();
			lm.bind(localeChangeHandler);
		}
		
		/**
		 * @private 
		 */	
		private var _text:String;
		
		/**
		 * @iheritDoc 
		 */	
		override public function get text():String
		{
			return _text;
		}
		
		/**
		 * Return localized text. 
		 */		
		public function get textLocalized():String
		{
			return super.text;
		}
		
		/**
		 * @iheritDoc 
		 */	
		override public function set text(value:String):void
		{
			_text = value;
			
			super.text = lm.localize(_text);
		}
		
		/**
		 * @private 
		 */		
		private function localeChangeHandler(e:BindingEvent):void
		{
			if(_text)
				super.text = lm.localize(_text);
		}
		
		/**
		 * Layout Manager object. 
		 */		
		protected var layoutManager:LayoutManager;
		
		/**
		 * @private 
		 */		
		private var lm:LocaleManager;
		
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

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
	import com.in4ray.gaming.layouts.context.BasicLayoutContext;
	import com.in4ray.gaming.layouts.context.ILayoutContext;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * Flash sprite class that hase layout capabilities. 
	 */	
	public class Sprite extends flash.display.Sprite implements IVisualContainer
	{
		/**
		 * Constructor. 
		 */		
		public function Sprite()
		{
			super();
			layoutManager = new LayoutManager(this);
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler, false, int.MAX_VALUE);
		}
		
		private function addedToStageHandler(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			createChildren();
		}
		
		/**
		 * Override this method to create/add children. Will be called on firstly added to stage.
		 */		
		protected function createChildren():void
		{
			// to be overriden	
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
		
		public function layoutChildren():void
		{
			for (var i:int = 0; i < numChildren; i++) 
			{
				var element:IVisualElement = getChildAt(i) as IVisualElement;
				if(element)
					element.layout();
			}
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
		
		/**
		 * @private 
		 */		
		protected var _layoutContext:ILayoutContext;
		
		public function set layoutContext(layoutContext:ILayoutContext):void
		{
			_layoutContext = layoutContext;
		}
		
		/**
		 * @inheritDoc
		 */	
		public function get layoutContext():ILayoutContext
		{
			if(!_layoutContext)
				_layoutContext = new BasicLayoutContext(this);
			
			return _layoutContext;
		}
		
		override public function set x(value:Number):void
		{
			throw Error("Forbidden, use layouts");
		}
		
		override public function set y(value:Number):void
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
				_width = w;
			if(!isNaN(h))
				_height = h;
			if(!isNaN(w) || !isNaN(h))
				layoutChildren();
		}
		
		/**
		 * @inheritDoc
		 */	
		public function addElement(element:IVisualElement, ...layouts):void
		{
			addChild(element as DisplayObject);
			if(layouts.length > 0)
			{
				element.addLayout.apply(null, layouts);
				element.layout();
			}
		}
		
		/**
		 * @inheritDoc
		 */	
		public function addElementAt(element:IVisualElement, index:int, ...layouts):void
		{
			addChildAt(element as DisplayObject, index);
			if(layouts.length > 0)
			{
				element.addLayout.apply(null, layouts);
				element.layout();
			}
		}
		
		/**
		 * @inheritDoc
		 */	
		public function removeElement(element:IVisualElement):IVisualElement
		{
			return removeChild(element as DisplayObject) as IVisualElement;
		}
		
		/**
		 * @inheritDoc
		 */	
		public function removeElementAt(index:int):IVisualElement
		{
			return removeChildAt(index) as IVisualElement;
		}
		
		private var _height:Number;
		
		/**
		 * @inheritDoc
		 */	
		override public function get height():Number
		{
			return !isNaN(_height) ? _height : super.height;
		}
		
		override public function set height(value:Number):void
		{
			throw Error("Forbidden, use layouts");
		}
		
		private var _width:Number;
		
		/**
		 * @inheritDoc
		 */	
		override public function get width():Number
		{
			return !isNaN(_width) ? _width : super.width;
		}
		
		override public function set width(value:Number):void
		{
			throw Error("Forbidden, use layouts");
		}
	}
}

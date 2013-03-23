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
	import com.in4ray.gaming.components.IVisualContainer;
	import com.in4ray.gaming.components.IVisualElement;
	import com.in4ray.gaming.components.Sprite;
	import com.in4ray.gaming.layouts.ILayout;
	import com.in4ray.gaming.layouts.ILayoutManager;
	import com.in4ray.gaming.layouts.context.ILayoutContext;

	/**
	 * Layout template, used to configure position of future added elements. 
	 */	
	public class Template implements IVisualContainer
	{
		/**
		 * Constructor.
		 *  
		 * @param container Layout container.
		 */		
		public function Template(container:Sprite)
		{
			super();
			_container = container;
		}
		
		/**
		 * List of place holders. 
		 */		
		public var placeHolders:Array = new Array();

		private var _container:Sprite;

		/**
		 * Layout container.
		 */		
		public function get container():Sprite
		{
			return _container;
		}

		
		/**
		 * Add placeholder that contains layout constraints.
		 *  
		 * @param layouts one or several layout constrains.
		 */		
		public function addPlaceHolder(...layouts):void
		{
			var placeHolder:PlaceHolder = new PlaceHolder();
			placeHolder.layouts = layouts;
			placeHolders.push(placeHolder);
		}
		
		/**
		 * @inheritDoc 
		 */		
		public function addElement(element:IVisualElement, ...layouts):void
		{
			var index:int = container.numChildren;
			container.addElement.apply(null, [element].concat(getElementLayouts(index)));
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function addElementAt(element:IVisualElement, index:int, ...layouts):void
		{
			container.addElementAt.apply(null, [element, index].concat(getElementLayouts(index)));
		}
		
		/**
		 * @private 
		 */	
		protected function getElementLayouts(index:uint):Array
		{
			return index < placeHolders.length ? (placeHolders[index] as PlaceHolder).getLayoutArray() : [];
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function removeElement(element:IVisualElement):IVisualElement
		{
			return container.removeElement(element);
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function removeElementAt(index:int):IVisualElement
		{
			return  container.removeElementAt(index);
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function get numChildren():int
		{
			return container.numChildren;
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function layoutChildren():void
		{
			container.layoutChildren();
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function set layoutContext(value:ILayoutContext):void
		{
			container.layoutContext = value;
		}
		/**
		 * @inheritDoc 
		 */	
		
		public function get layoutContext():ILayoutContext
		{
			return container.layoutContext;
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function addLayout(...layouts):ILayoutManager
		{
			return container.addLayout.apply(null, layouts);
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function getLayout(layoutFunc:Function):ILayout
		{
			return container.getLayout(layoutFunc);
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function getLayouts():Vector.<ILayout>
		{
			return container.getLayouts();
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function layout():void
		{
			container.layout();
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function get parentContext():ILayoutContext
		{
			return container.parentContext;
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function removeLayout(layout:Function):ILayoutManager
		{
			return container.removeLayout(layout);
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function setActualPosition(x:Number, y:Number):void
		{
			container.setActualPosition(x, y);
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function setActualSize(w:Number, h:Number):void
		{
			container.setActualSize(w, h);
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function setLayoutValue(layoutFunc:Function, value:Number, units:String = null):void
		{
			container.setLayoutValue(layoutFunc, value, units);
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function get width():Number
		{
			return container.width;
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function get height():Number
		{
			return container.height;
		}
		
		public function set x(value:Number):void
		{
			container.x = value;
		}
		
		/**
		 * @inheritDoc 
		 */
		public function get x():Number
		{
			return container.x;
		}
		
		public function set y(value:Number):void
		{
			container.y= value;
		}
		
		/**
		 * @inheritDoc 
		 */
		public function get y():Number
		{
			return container.y;
		}
		
		/**
		 * @inheritDoc 
		 */
		public function get rotation():Number
		{
			return 0;
		}
		
		/**
		 * @inheritDoc 
		 */
		public function set rotation(value:Number):void
		{
			
		}
	}
}
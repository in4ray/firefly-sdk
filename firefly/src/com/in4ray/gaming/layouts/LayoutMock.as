package com.in4ray.gaming.layouts
{
	import com.in4ray.gaming.components.IVisualContainer;
	import com.in4ray.gaming.components.IVisualElement;
	import com.in4ray.gaming.layouts.context.ILayoutContext;
	
	/**
	 * Mockup class that helps to calculate layouts. 
	 */	
	public class LayoutMock implements IVisualElement
	{
		/**
		 * Constructor.
		 *  
		 * @param parent Parent container.
		 */		
		public function LayoutMock(parent:IVisualContainer)
		{
			this.parent = parent;
			
			layoutManager = new LayoutManager(this);
		}
		
		private var parent:IVisualContainer;
		
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
			return parent ? parent.layoutContext : null;
		}
		
		private var _x:Number = 0;
		/**
		 * @inheritDoc 
		 */	
		public function get x():Number
		{
			return _x;
		}
		
		private var _y:Number = 0;
		/**
		 * @inheritDoc 
		 */	
		public function get y():Number
		{
			return _y;
		}
		
		private var _width:Number = 0;
		/**
		 * @inheritDoc 
		 */	
		public function get width():Number
		{
			return _width;
		}
		
		private var _height:Number = 0;
		/**
		 * @inheritDoc 
		 */	
		public function get height():Number
		{
			return _height;
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function setActualPosition(x:Number, y:Number):void
		{
			if(!isNaN(x))
				_x = x;
			if(!isNaN(y))
				_y = y;
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
		}
		
		private var _rotation:Number = 0;

		/**
		 * @inheritDoc 
		 */	
		public function get rotation():Number
		{
			return _rotation;
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function set rotation(value:Number):void
		{
			_rotation = value;
		}
	}
}
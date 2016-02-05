// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.layouts
{
	import com.firefly.core.Firefly;
	import com.firefly.core.firefly_internal;
	import com.firefly.core.layouts.helpers.LayoutContext;
	import com.firefly.core.layouts.helpers.LayoutElement;
	
	import flash.utils.Dictionary;

	use namespace firefly_internal;
	
	/** Absolute layout class. */ 
	public class Layout
	{
		/** @private */
		private const _elements:Dictionary = new Dictionary(true);
		
		/** @private */
		private var _container:Object;
		/** @private */
		private var _context:LayoutContext;
		
		/** Constructor.
		 *  @param container Flash or Starling container.
		 *  @param vAlign Vertical align.
		 *  @param hAlign Horizontal align. */		
		public function Layout(container:Object, vAlign:String = "", hAlign:String = "")
		{
			_container = container;
			_context = new LayoutContext(container, vAlign, hAlign);
		}
		
		/** Layout context of the container. */
		public function get context():LayoutContext { return _context; }
		
		/** Add child element into container and layout it.
		 *  @param child Flash or Starling display object.
		 *  @param layouts layout constraints. */		
		public function addElement(child:Object, ...layouts):void
		{
			addElementAt.apply(null, [child, _container.numChildren].concat(layouts)); 
		}
		
		/** Add child element into container at specified depth and layout it.
		 *  @param child Flash or Starling display object.
		 *  @param index Depth.
		 *  @param layouts layout constraints. */
		public function addElementAt(child:Object, index:uint, ...layouts):void
		{
			_context.width = _container.width;
			_context.height = _container.height;
			_container.addChildAt(child, index);
			
			var element:LayoutElement = new LayoutElement(child, layouts); 
			_elements[child] = element;
			if (Firefly.current)
				element.layout(_context);
		}
		
		/** Remove child element from container.
		 *  @param child Flash or Starling display object.
		 *  @param dispose Indicates of calling <code>dispose()</code> function after removing element. */
		public function removeElement(child:Object, dispose:Boolean=false):void
		{
			delete _elements[child];
            _container.removeChild(child, dispose);
		}
		
		/** Remove child element from container by index.
		 *  @param index Index of Flash or Starling display object.
		 *  @param dispose Indicates of calling <code>dispose()</code> function after removing element. */
		public function removeElementAt(index:int, dispose:Boolean=false):void
		{
			var child:Object = _container.getChildAt(index);
			
			delete _elements[child];
			_container.removeChild(child, dispose);
		}
		
		/** Get child element from container by index.
		 *  @param index Index of Flash or Starling display object. */
		public function getElementAt(index:int):Object
		{
			return _container.getChildAt(index);
		}
		
		/** Get child element index.
		 *  @param child Flash or Starling display object. */
		public function getElementIndex(child:Object):int
		{
			return _container.getChildIndex(child);
		}
		
		/** Layout all registered children. */		
		public function layout():void
		{
			_context.width = _container.width;
			_context.height = _container.height;
			for each (var element:LayoutElement in _elements) 
			{
				element.layout(_context);
			}
		}
		
		/** Perform layouting element.
		 *  @param child Flash or Starling display object.
		 *  @param layouts layout constraints. */
		public function layoutElement(child:Object, ...layouts):void
		{
			var element:LayoutElement = new LayoutElement(child, layouts); 
			if (Firefly.current)
				element.layout(_context);
		}
		
		/** Returns layout element asociated with specified child object.
		 *  @param child Flash or Starling display object.
		 *  @return Layout Element object. */		
		public function getLayoutElement(child:Object):LayoutElement
		{
			return _elements[child];
		}
		
		/** @copy com.firefly.core.layouts.helpers.LayoutContext#layoutToRealByX() */	
		public function layoutToRealByX(value:Number, units:String, respectCropping:Boolean=false):Number
		{
			return _context.layoutToRealByX(value, units, respectCropping);
		}
		
		/** @copy com.firefly.core.layouts.helpers.LayoutContext#layoutToRealByY() */
		public function layoutToRealByY(value:Number, units:String, respectCropping:Boolean=false):Number
		{
			return _context.layoutToRealByY(value, units, respectCropping);
		}
		
		/** @copy com.firefly.core.layouts.helpers.LayoutContext#realToLayoutByX() */
		public function realToLayoutByX(value:Number, units:String, respectCropping:Boolean=false):Number
		{
			return _context.realToLayoutByX(value, units, respectCropping);
		}
		
		/** @copy com.firefly.core.layouts.helpers.LayoutContext#realToLayoutByY() */
		public function realToLayoutByY(value:Number, units:String, respectCropping:Boolean=false):Number
		{
			return _context.realToLayoutByY(value, units, respectCropping);
		}
	}
}
// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.layouts
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.layouts.helpers.LayoutContext;
	import com.firefly.core.layouts.helpers.LayoutElement;

	use namespace firefly_internal;
	
	/** Absolute layout class. */ 
	public class Layout
	{
		private const _elements:Vector.<LayoutElement> = new Vector.<LayoutElement>();
		
		private var _container:Object;
		private var _context:LayoutContext;
		
		/** Constructor.
		 *  @param container Flash or Starling container.
		 *  @param vAlign Vertical align.
		 *  @param hAlign Horizontal align. */		
		public function Layout(container:Object, vAlign:String = "", hAlign:String = "")
		{
			_container = container;
			
			_context = new LayoutContext(vAlign, hAlign);
			_context.width = container.width;
			_context.height = container.height;
		}
		
		/** Add child element into container and layout it.
		 *  @param child Flash or Starling display object.
		 *  @param layouts layout constraints. */		
		public function addElement(child:Object, ...layouts):void
		{
			_container.addChild(child);
			var element:LayoutElement = new LayoutElement(child, layouts); 
			_elements.push(element);
			element.layout(_context);
		}
		
		/** Add child element into container at specified depth and layout it.
		 *  @param child Flash or Starling display object.
		 *  @param index Depth.
		 *  @param layouts layout constraints. */
		public function addElementAt(child:Object, index:uint, ...layouts):void
		{
			_container.addChildAt(child, index);
			var element:LayoutElement = new LayoutElement(child, layouts); 
			_elements.push(element);
			element.layout(_context);
		}
		
		/** Remove child element from container.
		 *  @param child Flash or Starling display object. */
		public function removeElement(child:Object):void
		{
			for (var i:int = 0; i < _elements.length; i++) 
			{
				if(_elements[i]._target == child)
				{
					_container.removeChild(_elements.splice(i, 1)[0]);
					return
				}
			}
		}
		
		/** Layout all registered children. */		
		public function layout():void
		{
			for each (var element:LayoutElement in _elements) 
			{
				element.layout(_context);
			}
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
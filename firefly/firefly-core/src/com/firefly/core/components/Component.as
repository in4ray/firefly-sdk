// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.components
{
	import com.firefly.core.display.ILayoutComponent;
	import com.firefly.core.layouts.Layout;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	
	/** The Component is a basic container which supports placing own children using <code>Layout</code> 
	 *  class with a  lot of possibilities. If you want to place components that would automatically 
	 *  calculates its  position, component size for all resoultions use <code>Layout</code> instance 
	 *  to add them. If you want to add them without layouting just use standard functions <code>addChild</code> 
	 *  and <code>addChildAt</code>. Also this class supports possibility of dispatching touch events 
	 *  in case component hasn't any children with texture, but has width and hight more than 0. You 
	 *  just need to set <code>touchableWhereTransparent</code> by <code>true</code>. 
	 * 
	 *  @see com.firefly.core.layouts.Layout
	 *  @see com.firefly.core.layouts.constraints.LayoutConstraint */	
	public class Component extends Sprite implements ILayoutComponent
	{
		/** @private */		
		private var _width:Number;
		/** @private */
		private var _height:Number;
		/** @private */
		private var _layout:Layout;
		/** @private */
		private var _touchableWhereTransparent:Boolean;
		/** @private */
		private var _helperRect:Rectangle;
		/** @private */
		private var _helperPoint:Point;
		
		/** Constructor.
		 *  @param layout Layout which be used to positioning elements. */	
		public function Component(layout:Layout = null)
		{
			super();
			
			_layout = layout ? layout : new Layout(this);
		}
		
		/** @inheritDoc */
		override public function get width():Number { return !isNaN(_width) ? _width : super.width; }
		override public function set width(value:Number):void { _width = value; }
		/** @inheritDoc */
		override public function get height():Number { return !isNaN(_height) ? _height : super.height; }
		override public function set height(value:Number):void { _height = value; }
		
		/** Set this parameter to <code>true</code> in case you want in order this component dispatches 
		 *  touch events where children haven't any textures and component has size. */
		public function get touchableWhereTransparent():Boolean { return _touchableWhereTransparent; }
		public function set touchableWhereTransparent(value:Boolean):void { _touchableWhereTransparent = value; }
		
		/** Layout for positioning elements. */
		public function get layout():Layout { return _layout; }
		
		/** Update geometry of all elements in the container bases on layout. */
		public function updateLayout():void
		{
			_layout.layout();
		}
		
		/** @inheritDoc */
		override public function hitTest(localPoint:Point, forTouch:Boolean=false):DisplayObject
		{
			if (!_helperPoint)
				_helperPoint = new Point();
			
			_helperPoint.copyFrom(localPoint);
			
			var displayObject:DisplayObject = super.hitTest(localPoint, forTouch);
			if (touchableWhereTransparent && !displayObject && !isNaN(_width) && !isNaN(_height))
			{
				if (forTouch && (!visible || !touchable)) 
					return null;
				if (!_helperRect)
					_helperRect = new Rectangle();
				
				_helperRect.x = x;
				_helperRect.y = y;
				_helperRect.width = _width;
				_helperRect.height = _height;
				
				if (_helperRect.containsPoint(_helperPoint)) 
					return this;
			}
			
			return displayObject;
		}
	}
}
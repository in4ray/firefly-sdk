package com.firefly.core.components
{
	import com.firefly.core.display.ILayoutComponent;
	import com.firefly.core.layouts.Layout;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	
	public class Component extends Sprite implements ILayoutComponent
	{
		private var _width:Number;
		private var _height:Number;
		private var _layout:Layout;
		private var _touchableWhereTransparent:Boolean
		private var _helperRect:Rectangle;
		private var _helperPoint:Point;
		
		/** Constructor.
		 *  @param layout Layout which be used to positioning elements. */	
		public function Component(layout:Layout = null)
		{
			super();
			
			if (layout)
				_layout = layout;
			else
				_layout = new Layout(this);
		}
		
		/** @inheritDoc */
		override public function get width():Number { return !isNaN(_width) ? _width : super.width; }
		override public function set width(value:Number):void { _width = value; }
		/** @inheritDoc */
		override public function get height():Number { return !isNaN(_height) ? _height : super.height; }
		override public function set height(value:Number):void { _height = value; }
		
		public function get touchableWhereTransparent():Boolean { return _touchableWhereTransparent; }
		public function set touchableWhereTransparent(value:Boolean):void { _touchableWhereTransparent = value; }
		
		/** Layout for positioning elements. */
		public function get layout():Layout { return _layout; }
		
		/** Update geometry of all elements in the container bases on layout. */
		public function updateLayout():void
		{
			_layout.layout();
		}
		
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
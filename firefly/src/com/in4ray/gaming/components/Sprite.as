// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.components
{
	import com.in4ray.gaming.layouts.ILayout;
	import com.in4ray.gaming.layouts.ILayoutManager;
	import com.in4ray.gaming.layouts.LayoutManager;
	import com.in4ray.gaming.layouts.context.BasicLayoutContext;
	import com.in4ray.gaming.layouts.context.ILayoutContext;
	import com.in4ray.gaming.navigation.ViewNavigator;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import starling.core.RenderSupport;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * Starling sprite container with additional capabilities.  
	 */	
	public class Sprite extends starling.display.Sprite implements IVisualContainer 
	{
		/**
		 * Constructor. 
		 */		
		public function Sprite()
		{
			super();
			
			layoutManager = new LayoutManager(this);
		}
		
		private var mouseShield:starling.display.Quad;
		
		private var _touchableWhereTransparent:Boolean;

		/**
		 * Flag indicates whether container should be touchable on transparent areas. 
		 * 
		 * @default false
		 */		
		public function get touchableWhereTransparent():Boolean
		{
			return _touchableWhereTransparent;
		}

		public function set touchableWhereTransparent(value:Boolean):void
		{
			if(_touchableWhereTransparent != value)
			{
				if(value)
				{
					mouseShield = new starling.display.Quad(1,1);
					mouseShield.alpha = 0;
					mouseShield.width = width;
					mouseShield.height = height;
					addChildAt(mouseShield, 0);
				}
				else
				{
					removeChild(mouseShield);
					mouseShield = null;
				}
				
				_touchableWhereTransparent = value;
			}
		}
		
		/**
		 * View navigation manager. 
		 */		
		public var navigator:ViewNavigator;
		
		/**
		 * Layout Manager object. 
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
			
			if(mouseShield)
			{
				mouseShield.width = width;
				mouseShield.height = height;
			}
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function addElement(element:IVisualElement, ...layouts):void
		{
			addElementAt.apply(null, [element, numChildren].concat(layouts));
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function addElementAt(element:IVisualElement, index:int, ...layouts):void
		{
			addChildAt(element as DisplayObject, index);
			
			applyLayouts(element, layouts);
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
		
		private function applyLayouts(element:IVisualElement, layouts:Array):void
		{
			if(layouts.length > 0)
			element.addLayout.apply(null, layouts);
			
			if(element.getLayouts().length > 0)
				element.layout();
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function getLayouts():Vector.<ILayout>
		{
			return layoutManager.getLayouts();
		}
		
		private var _width:Number;
		override public function get width():Number
		{
			return !isNaN(_width) ? _width : super.width;
		}
		
		override public function set width(value:Number):void
		{
			throw Error("Forbidden, use layouts");
		} 
		
		private var _height:Number;
		override public function get height():Number
		{
			return !isNaN(_height) ? _height : super.height;
		}
		
		override public function set height(value:Number):void
		{
			throw Error("Forbidden, use layouts");
		}
		
		//////////// clipping ///////////////
		private var _clipContent:Boolean;
		
		/**
		 * Flag that indicates whether content should be clipped by container size. 
		 * @default false
		 */		
		public function get clipContent():Boolean
		{
			return _clipContent && rotation == 0;
		}
		
		public function set clipContent(value:Boolean):void
		{
			_clipContent = value;
		}
		
		private static var _currentScissorRectangle:Rectangle;
		
		/**
		 * Used for clipping content 
		 */		
		public static function get currentScissorRectangle():Rectangle
		{
			return _currentScissorRectangle;
		}
		
		public static function setScissorRectangle(rect:Rectangle):void
		{
			Starling.context.setScissorRectangle(rect);
			_currentScissorRectangle = rect;
		}
		
		
		public override function render(support:RenderSupport, alpha:Number):void
		{
			if(clipContent)
			{
				var prevScissorRectangle:Rectangle = currentScissorRectangle;
				var clipRect:Rectangle = getClipRect();
				if(currentScissorRectangle)
					clipRect = clipRect.intersection(currentScissorRectangle);
				support.finishQuadBatch();
				if(clipRect.width > 0 && clipRect.height > 0)
				{
					setScissorRectangle(clipRect);
					super.render(support,alpha);
					support.finishQuadBatch();
					setScissorRectangle(prevScissorRectangle);
				}
			}
			else
			{
				super.render(support,alpha);
			}
		}
		
		private function getClipRect():Rectangle
		{
			var topLeft:Point = localToGlobal(new Point());
			var bottomRight:Point = localToGlobal(new Point(_width, _height));
			
			return new Rectangle(topLeft.x, topLeft.y, bottomRight.x-topLeft.x, bottomRight.y-topLeft.y);
		}
		
		public override function hitTest(localPoint:Point, forTouch:Boolean=false):DisplayObject
		{
			// without a clip rect, the sprite should behave just like before
			if (!clipContent) 
				return super.hitTest(localPoint, forTouch); 
			
			// on a touch test, invisible or untouchable objects cause the test to fail
			if (forTouch && (!visible || !touchable)) return null;
			
			var scale:Number = Starling.current.contentScaleFactor;
			var globalPoint:Point = localToGlobal(localPoint);
			
			var clipRect:Rectangle = getClipRect();
			
			if (clipRect.contains(globalPoint.x, globalPoint.y))
				return super.hitTest(localPoint, forTouch);
			else
				return null;
		}
		
	}
}
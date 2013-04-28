// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.layouts
{
	import com.in4ray.gaming.components.IVisualElement;

	[ExcludeClass]
	/**
	 * Layout target, special objetc that used to calculate position and size 
	 * before applying it to visual element. 
	 */	
	public class LayoutTarget
	{
		/**
		 * Constructor. 
		 */		
		public function LayoutTarget()
		{
		}
		
		public function reset(element:IVisualElement):void
		{
			_x = element.x;
			_y = element.y;
			_width = element.width;
			_height = element.height;
			_pivotX = element.pivotX;
			_pivotY = element.pivotY;
			
			_xChanged = false;
			_yChanged = false;
			_widthChanged = false;
			_heightChanged = false;
			_pivotXChanged = false;
			_pivotYChanged = false;
		}
		
		public function apply(element:IVisualElement):void
		{
			var x:Number = (_xChanged ? _x : NaN);
			var y:Number = (_yChanged ? _y : NaN);
			element.setActualPosition(x, y);
			
			var w:Number = (_widthChanged ? _width : NaN);
			var h:Number = (_heightChanged ? _height : NaN);
			element.setActualSize(w, h);
			
			var px:Number = (_pivotXChanged ? _pivotX : NaN);
			var py:Number = (_pivotYChanged ? _pivotY : NaN);
			element.setActualPivots(px, py);
		}
		
		private var _x:Number;

		public function get x():Number
		{
			return _x;
		}

		public function setX(value:Number):void
		{
			_x = value;
			_xChanged = true;
		}
		
		private var _xChanged:Boolean;

		public function get xChanged():Boolean
		{
			return _xChanged;
		}


		private var _y:Number;

		public function get y():Number
		{
			return _y;
		}

		public function setY(value:Number):void
		{
			_y = value;
			_yChanged = true;
		}
		
		private var _yChanged:Boolean;
		
		public function get yChanged():Boolean
		{
			return _yChanged;
		}

		private var _width:Number;

		public function get width():Number
		{
			return _width;
		}

		public function setWidth(value:Number):void
		{
			_width = value;
			
			_widthChanged = true;
		}
		
		private var _widthChanged:Boolean;
		
		public function get widthChanged():Boolean
		{
			return _widthChanged;
		}

		private var _height:Number;

		public function get height():Number
		{
			return _height;
		}

		public function setHeight(value:Number):void
		{
			_height = value;
			
			_heightChanged = true;
		}

		private var _heightChanged:Boolean;
		
		public function get heightChanged():Boolean
		{
			return _heightChanged;
		}
		
		private var _pivotX:Number;
		
		public function get pivotX():Number
		{
			return _pivotX;
		}
		
		public function setPivotX(value:Number):void
		{
			_pivotX = value;
			_pivotXChanged = true;
		}
		
		private var _pivotXChanged:Boolean;
		
		public function get pivotXChanged():Boolean
		{
			return _pivotXChanged;
		}
		
		private var _pivotY:Number;
		
		public function get pivotY():Number
		{
			return _pivotY;
		}
		
		public function setPivotY(value:Number):void
		{
			_pivotY = value;
			_pivotYChanged = true;
		}
		
		private var _pivotYChanged:Boolean;
		
		public function get pivotYChanged():Boolean
		{
			return _pivotYChanged;
		}
	}
}
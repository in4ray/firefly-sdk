// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.layouts.helpers
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.layouts.constraints.LayoutConstraint;
	
	use namespace firefly_internal;
	
	/** Layout element, special object that used to calculate position and size 
	 *  before applying it to visual element. */	
	public class LayoutElement
	{
		private var _x:Number;
		private var _y:Number;
		private var _width:Number;
		private var _height:Number;
		private var _pivotX:Number;
		private var _pivotY:Number;
		
		firefly_internal var _xChanged:Boolean;
		firefly_internal var _yChanged:Boolean;
		firefly_internal var _widthChanged:Boolean;
		firefly_internal var _heightChanged:Boolean;
		firefly_internal var _pivotXChanged:Boolean;
		firefly_internal var _pivotYChanged:Boolean;

		firefly_internal var _target:Object;
		firefly_internal var _constraints:Array;
		
		/** Constructor.
		 *  @param target Target of layouting (Flash or Starling display object).
		 *  @param constraints List of layout constraints. */		
		public function LayoutElement(target:Object = null, constraints:Array=null)
		{
			_constraints = constraints;
			_target = target;
			
			sort();
		}
		
		/** Position by X-axis. */		
		public function get x():Number { return _x; }
		public function set x(value:Number):void
		{
			_x = value;
			_xChanged = true;
		}
		
		/** Position by Y-axis. */
		public function get y():Number {	return _y; }
		public function set y(value:Number):void
		{
			_y = value;
			_yChanged = true;
		}
		
		/** Width. */
		public function get width():Number { return _width; }
		public function set width(value:Number):void
		{
			_width = value;
			_widthChanged = true;
		}
		
		/** Height. */
		public function get height():Number { return _height; }
		public function set height(value:Number):void
		{
			_height = value;
			_heightChanged = true;
		}
		
		/** Pivot by X-axis. */
		public function get pivotX():Number { return _pivotX; }
		public function set pivotX(value:Number):void
		{
			_pivotX = value;
			_pivotXChanged = true;
		}
		
		/** Pivot by Y-axis. */
		public function get pivotY():Number { return _pivotY; }
		public function set pivotY(value:Number):void
		{
			_pivotY = value;
			_pivotYChanged = true;
		}
		
		/** Proceed layouting 
		 *  @param target Target of layouting (Flash or Starling display object).
		 *  @param constraints List of layout constraints. */
		public function layout(context:LayoutContext, target:Object= null, constraints:Array = null):void
		{
			if(target)
				_target = target;
			if(constraints)
				_constraints = constraints;
			
			sort();
			
			reset();
			
			for each (var constraint:LayoutConstraint in _constraints) 
			{
				constraint.layout(context, this);
			}
			
			apply();
		}
		
		/** Return layout constraint by its global function.
		 *  @param globalFunc Global function of constraint (e.g. $x, $top, $vCenter etc.).
		 *  @return Layout Constraint */		
		public function getConstraint(globalFunc:Function):LayoutConstraint
		{
			for each (var constraint:LayoutConstraint in _constraints) 
			{
				if(constraint.getGlobalFunc() == globalFunc)
					return constraint;
			}
			
			return null;
		}
		
		/** Add or replace constraint.
		 *  @param constraint Constraint to be added. */		
		public function addConstraint(constraint:LayoutConstraint):void
		{
			removeConstraint(constraint.getGlobalFunc());
			
			_constraints.push(constraint);
		}
		
		/** Remove constraint.
		 *  @param globalFunc Global function of constraint (e.g. $x, $top, $vCenter etc.). */		
		public function removeConstraint(globalFunc:Function):void
		{
			for (var i:int = 0; i < _constraints.length; i++) 
			{
				if(_constraints[i].getGlobalFunc() == globalFunc)
				{
					_constraints.splice(i, 1);
					break;
				}
			}
		}
		
		/** @private */
		private function reset():void
		{
			if(_target)
			{
				_x = _target.x;
				_y = _target.y;
				
				_width = _target.width;
				_height = _target.height;
				
				if(_target.hasOwnProperty("pivotX"))
					_pivotX = _target.pivotX;
				if(_target.hasOwnProperty("pivotY"))
					_pivotY = _target.pivotY;
			}
			
			_xChanged = _yChanged = false;
			_widthChanged = _heightChanged = false;
			_pivotXChanged = _pivotYChanged = false;
		}
		
		/** @private */
		private function apply():void
		{
			if(_target)
			{
				if(_pivotXChanged && _target.hasOwnProperty("pivotX"))
					_target.pivotX = _pivotX;
				if(_pivotYChanged && _target.hasOwnProperty("pivotY"))
					_target.pivotY = _pivotY;
				
				if(_xChanged)
					_target.x = _x;
				if(_yChanged)
					_target.y = _y;
				
				if(_widthChanged)
					_target.width = _width;
				if(_heightChanged)
					_target.height = _height;
			}
		}
		
		/** @private */
		private function sort():void
		{
			if(_constraints)
				_constraints.sortOn("order");
		}
	}
}

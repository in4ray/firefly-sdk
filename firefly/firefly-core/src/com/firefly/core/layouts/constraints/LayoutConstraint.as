// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.layouts.constraints
{
	import com.firefly.core.consts.LayoutUnits;
	import com.firefly.core.layouts.helpers.LayoutContext;
	import com.firefly.core.layouts.helpers.LayoutElement;
	
	/** Base layout constraint class.  */	
	public class LayoutConstraint implements ILayoutUnits
	{
		/** For layouts that change position. */		
		public static const POSITION:int = 0;
		
		/** For layouts that change size. */	
		public static const SIZE:int = 10;
		
		/** For layouts first constrains. */	
		public static const FIRST_CONSTRAINS:int = 20;
		
		/** For layouts that change pivots */	
		public static const PIVOTS:int = 40;
		
		/** For layouts second constrains. */	
		public static const SECOND_CONSTRAINS:Number = 50;
		
		protected static const elementContext:LayoutContext = new LayoutContext();
		
		private var _units:String = LayoutUnits.CPX;
		private var _globalFunc:Function;
		private var _value:Number;
		private var _order:uint;
		
		/** Constructor.
		 *  @param order Order of layouting procedure.
		 *  @param globalFunc Global function that creates this layout constraint e.g. $x, $width, $bottom, etc. */		
		public function LayoutConstraint(value:Number, order:uint, globalFunc:Function)
		{
			_order = order;
			_value = value;
			_globalFunc = globalFunc;
		}
		
		/** @inheritDoc */		
		public function layout(context:LayoutContext, element:LayoutElement):void {}

		/** @inheritDoc */	
		public function get units():String{	return _units; }
		
		/** @inheritDoc */	
		public function get value():Number { return _value; }
		
		/** @inheritDoc */	
		public function getGlobalFunc():Function { return _globalFunc; }
		
		/** @inheritDoc */	
		public function get px():LayoutConstraint
		{
			_units = LayoutUnits.PX;
			return this;
		}
		
		/** @inheritDoc */	
		public function get cpx():LayoutConstraint
		{
			_units = LayoutUnits.CPX;
			return this;
		}
		
		/** @inheritDoc */	
		public function get pct():LayoutConstraint
		{
			_units = LayoutUnits.PCT; 
			return this;
		}
		
		/** @inheritDoc */	
		public function get inch():LayoutConstraint
		{
			_units = LayoutUnits.INCH; 
			return this;
		}
		
		/** @inheritDoc */	
		public function get order():uint
		{
			return _order;
		}
	}
}
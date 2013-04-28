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
	import com.in4ray.gaming.consts.LayoutUnits;
	import com.in4ray.gaming.layouts.context.ILayoutContext;
	
	
	/**
	 * Base layout constraint class. 
	 */	
	public class LayoutBase implements ILayout, ILayoutUnits
	{

		private var _value:Number;
		private var units:String = LayoutUnits.PX;
		private var globalFunc:Function;
		
		/**
		 * Constructor.
		 *  
		 * @param value Layout value.
		 * @param globalFunc Global function that creates this layout constraint e.g. $x, $width, $bottom, etc.
		 */		
		public function LayoutBase(value:Number, globalFunc:Function)
		{
			this.globalFunc = globalFunc;
			_value = value;
		}
		
		/**
		 * @inheritDoc
		 */		
		public function layout(context:ILayoutContext, target:LayoutTarget, targetContext:ILayoutContext):void
		{
		}
		
		/**
		 * @inheritDoc
		 */	
		public function get value():Number
		{
			return _value;
		}
		
		public function set value(value:Number):void
		{
			_value = value;
		}
		
		/**
		 * @inheritDoc
		 */	
		public function getUnits():String
		{
			return units;
		}
		
		/**
		 * @inheritDoc
		 */	
		public function getGlobalFunc():Function
		{
			return globalFunc;
		}
		
		/**
		 * @inheritDoc
		 */	
		public function get px():ILayout
		{
			units = LayoutUnits.PX;
			return this;
		}
		
		/**
		 * @inheritDoc
		 */	
		public function get pct():ILayout
		{
			units = LayoutUnits.PCT; 
			return this;
		}
		
		/**
		 * @inheritDoc
		 */	
		public function get inch():ILayout
		{
			units = LayoutUnits.INCH; 
			return this;
		}
		
		/**
		 * @inheritDoc
		 */	
		public function get acpx():ILayout
		{
			units = LayoutUnits.ACPX; 
			return this;
		}
		
		/**
		 * @inheritDoc
		 */	
		public function get rcpx():ILayout
		{
			units = LayoutUnits.RCPX; 
			return this;
		}
		
		/**
		 * @inheritDoc
		 */	
		public function getOrder():uint
		{
			return 0;
		}
	}
}
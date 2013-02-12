// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.binding
{
	/**
	 * Bindable property for Number type. 
	 */	
	public class BindableNumber extends Bindable
	{
		/**
		 * Constuctor.
		 *  
		 * @param value Initial property value.
		 */
		public function BindableNumber(value:Number=NaN)
		{
			super(value);
		}
		
		public function set value(value:Number):void
		{
			setValue(value);
		}
		
		/**
		 * Property Number value. 
		 */
		public function get value():Number
		{
			return getValue() as Number;
		}
	}
}
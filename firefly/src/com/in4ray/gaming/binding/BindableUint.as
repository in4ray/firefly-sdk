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
	 * Bindable property for uint type. 
	 */	
	public class BindableUint extends Bindable
	{
		/**
		 * Constuctor.
		 *  
		 * @param value Initial property value.
		 */
		public function BindableUint(value:uint=0)
		{
			super(value);
		}
		
		public function set value(value:uint):void
		{
			setValue(value);
		}
		
		/**
		 * Property uint value. 
		 */
		public function get value():uint
		{
			return getValue() as uint;
		}
	}
}
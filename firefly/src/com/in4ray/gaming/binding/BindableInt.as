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
	 * Bindable property for int type. 
	 */	
	public class BindableInt extends Bindable
	{
		/**
		 * Constuctor.
		 *  
		 * @param value Initial property value.
		 */
		public function BindableInt(value:int=0)
		{
			super(value);
		}
		
		public function set value(value:int):void
		{
			setValue(value);
		}
		
		/**
		 * Property int value. 
		 */
		public function get value():int
		{
			return getValue() as int;
		}
	}
}
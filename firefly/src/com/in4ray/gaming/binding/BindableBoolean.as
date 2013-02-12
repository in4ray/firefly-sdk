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
	 * Bindable property for Boolean type. 
	 */	
	public class BindableBoolean extends Bindable
	{
		/**
		 * Constuctor.
		 *  
		 * @param value Initial property value.
		 */
		public function BindableBoolean(value:Boolean=false)
		{
			super(value);
		}
		
		public function set value(value:Boolean):void
		{
			setValue(value);
		}
		
		/**
		 * Property boolean value. 
		 */	
		public function get value():Boolean
		{
			return getValue() as Boolean;
		}
	}
}
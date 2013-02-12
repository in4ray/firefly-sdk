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
	 * Bindable property for String type. 
	 */	
	public class BindableString extends Bindable
	{
		/**
		 * Constuctor.
		 *  
		 * @param value Initial property value.
		 */
		public function BindableString(value:String=null)
		{
			super(value);
		}
		
		public function set value(value:String):void
		{
			setValue(value);
		}
		
		/**
		 * Property String value. 
		 */
		public function get value():String
		{
			return getValue() as String;
		}
	}
}
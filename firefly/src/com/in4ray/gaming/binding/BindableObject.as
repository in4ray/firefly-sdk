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
	 * Basic bindable property.
	 */	
	public class BindableObject extends Bindable
	{
		/**
		 * Constructor.
		 *  
		 * @param value initial property value.
		 */		
		public function BindableObject(value:Object=null)
		{
			super(value);
		}
		
		public function set value(value:Object):void
		{
			setValue(value);
		}
		
		/**
		 * Property value. 
		 */		
		public function get value():Object
		{
			return getValue();
		}
	}
}
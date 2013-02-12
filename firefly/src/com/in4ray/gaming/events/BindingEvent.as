// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.events
{
	import starling.events.Event;
	
	/**
	 * General binding event. 
	 */	
	public class BindingEvent extends Event
	{
		/**
		 * Property change event type. 
		 */		
		public static const PROPERTY_CHANGE:String = "propertyChange";
		
		/**
		 * Constructor.
		 *  
		 * @param data New binding value.
		 */		
		public function BindingEvent(data:Object=null)
		{
			super(PROPERTY_CHANGE, false, data);
		}
	}
}
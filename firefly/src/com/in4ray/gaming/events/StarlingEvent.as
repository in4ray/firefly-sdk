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
	import flash.events.Event;
	
	/**
	 * Event for starling system.  
	 */	
	public class StarlingEvent extends Event
	{
		/**
		 * Starling is initialized. 
		 */		
		public static const STARLING_INITIALIZED:String = "starlingInitialized";
		
		/**
		 * Constructor.
		 *  
		 * @param type Event type
		 */		
		public function StarlingEvent(type:String)
		{
			super(type);
		}
	}
}
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
	 * Global system events. 
	 */	
	public class SystemEvent extends Event
	{
		/**
		 * System activated 
		 */		
		public static const ACTIVATE:String = "activate";
		
		/**
		 * System deactivated (go to hibernate). 
		 */
		public static const DEACTIVATE:String = "deactivate";
		
		/**
		 * GPU context is lost. 
		 */		
		public static const CONTEXT_CREATE:String = "contextCreate";
		
		/**
		 * GPU context is created. 
		 */		
		public static const CONTEXT_LOST:String = "contextLost";
		
		/**
		 * Constructor.
		 *  
		 * @param type Event type
		 */		
		public function SystemEvent(type:String)
		{
			super(type);
		}
	}
}
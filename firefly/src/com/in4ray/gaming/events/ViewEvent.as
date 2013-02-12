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
	 * Event for containers that added to view navigator. 
	 */	
	public class ViewEvent extends Event
	{
		/**
		 * Adding view transition is started. 
		 */		
		public static const ADDING_TO_NAVIGATOR:String = "addingToNavigator";
		
		/**
		 * View showed in navigator. 
		 */
		public static const ADDED_TO_NAVIGATOR:String = "addedToNavigator";
		
		/**
		 * Removing view transition is started. 
		 */
		public static const REMOVING_FROM_NAVIGATOR:String = "removingFromNavigator";
		
		/**
		 * View removed from navigator. 
		 */
		public static const REMOVED_FROM_NAVIGATOR:String = "removedFromNavigator";
		
		/**
		 * Close state. 
		 */		
		public static const CLOSE:String = "close";
		
		/**
		 * Constructor.
		 *  
		 * @param type Event type.
		 */		
		public function ViewEvent(type:String)
		{
			super(type);
		}
	}
}
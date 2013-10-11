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
	 * Event that indicates that view port of view map changing it's position. 
	 */	
	public class NavigationMapEvent extends Event
	{
		/**
		 * Screen starts moving by finger. 
		 */		
		public static const SCREEN_MOVING:String = "screenMoving";
		
		/**
		 * Screen starts changing it's index. 
		 */
		public static const SCREEN_CHANGING:String = "screenChanging";
		
		/**
		 * Screen changed it's index. 
		 */
		public static const SCREEN_CHANGE:String = "screenChange";
		
		/**
		 * Screen update. 
		 */
		public static const SCREEN_UPDATE:String = "screenUpdate";
		
		private var _fromIndex:int;

		/**
		 * Previous screen index. 
		 */		
		public function get fromIndex():int
		{
			return _fromIndex;
		}

		private var _toIndex:int;
		
		/**
		 * Next screen index. 
		 */
		public function get toIndex():int
		{
			return _toIndex;
		}

		/**
		 * Constructor.
		 *  
		 * @param type Event type.
		 * @param fromIndex Previous screen index. 
		 * @param toIndex Next screen index. 
		 */		
		public function NavigationMapEvent(type:String, fromIndex:int, toIndex:int = -1)
		{
			super(type, bubbles, data);
			_toIndex = toIndex;
			_fromIndex = fromIndex;
		}
	}
}
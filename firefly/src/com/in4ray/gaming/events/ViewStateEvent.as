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
	 * View navigator events. 
	 */	
	public class ViewStateEvent extends Event
	{
		/**
		 * System deactivated. 
		 */		
		public static const DEACTIVATE:String = "deactivate";
		
		/**
		 * System activated. 
		 */		
		public static const ACTIVATE:String = "activate";
		
		/**
		 * GPU context is lost. 
		 */		
		public static const CONTEXT_LOST:String = "contextCreate";
		
		/**
		 * GPU context is created. 
		 */		
		public static const CONTEXT_CREATE:String = "contextLost";
		
		/**
		 * Back button pressed. 
		 */		
		public static const BACK:String = "back";
		
		/**
		 * Switch to state. 
		 */		
		public static const SWITCH_TO_STATE:String = "switchToState";
		
		/**
		 * Open popup. 
		 */		 
		public static const OPEN_POPUP:String = "openPoPup";
		
		/**
		 * Close popup. 
		 */		
		public static const CLOSE_POPUP:String = "closePoPup";

		private var _state:String;

		/**
		 * View state. 
		 */		
		public function get state():String
		{
			return _state;
		}

		/**
		 * Constructor.
		 *  
		 * @param type Event type.
		 * @param state View state.
		 */		
		public function ViewStateEvent(type:String, state:String = "")
		{
			super(type, true);
			_state = state;
		}
	}
}
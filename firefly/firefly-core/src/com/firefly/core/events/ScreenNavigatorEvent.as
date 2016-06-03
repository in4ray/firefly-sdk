// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.events
{
	import starling.events.Event;
	
	/** Event for screen navigator which shows changes in screen navigator component. */
	public class ScreenNavigatorEvent extends Event
	{
		/** State changed in the screen navigator.*/
		public static const STATE_CHANGED:String = "stateChanged";
		/** Screen navigator initialized.*/
		public static const INITIALIZED:String = "initialized";

		/** @private */		
		private var _state:String;
		
		/** Constructor.
		 *  @param type Event type.
		 *  @param state State of the screen navigator. */		
		public function ScreenNavigatorEvent(type:String, state:String)
		{
			super(type);
			
			_state = state;
		}

		/** State of the screen navigator. */		
		public function get state():String { return _state; }
	}
}
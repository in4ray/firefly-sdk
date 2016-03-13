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
	
	public class ScreenNavigatorEvent extends Event
	{
		public static const STATE_CHANGED:String = "stateChanged";
		public static const INITIALIZED:String = "initialized";

		private var _state:String;
		
		public function ScreenNavigatorEvent(type:String, state:String)
		{
			super(type);
			
			_state = state;
		}

		public function get state():String { return _state; }

	}
}
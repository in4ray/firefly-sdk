// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.builder.events
{
	import com.firefly.core.effects.easing.IEaser;
	
	import flash.events.Event;
	
	public class EaseDataEvent extends Event
	{
		public static const EASER_CHANGE:String = "easerChange";
		
		public var easer:IEaser;
		
		public function EaseDataEvent(type:String, easer:IEaser, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this.easer = easer;
		}
	}
}
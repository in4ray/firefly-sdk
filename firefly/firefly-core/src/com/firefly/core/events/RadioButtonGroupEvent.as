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

	/** Event for radio button group. */
	public class RadioButtonGroupEvent extends Event
	{
		/** Radio button is selected.*/		
		public static const CHANGE:String = "change";
		
		private var _index:int;
		
		/** Index of selected radio button. */		
		public function get index():int { return _index; }
		
		/** Constructor.
		 *  
		 * @param type Event type.
		 * @param index Index of selected radio button. */		
		public function RadioButtonGroupEvent(type:String, index:int)
		{
			super(type);
			_index = index;
		}
	}
}
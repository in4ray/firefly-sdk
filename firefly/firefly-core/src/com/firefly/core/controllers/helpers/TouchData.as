// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.controllers.helpers
{
	import com.firefly.core.consts.TouchType;

	/** Helper class which uses to store metadata about touching. */	
	public class TouchData
	{
		/** @private */		
		private var _x:Number;
		/** @private */
		private var _y:Number;
		/** @private */
		private var _phase:String;
		
		/** Constructor.
		 *  @param x Touch x axis position.
		 *  @param y Touch y axis position.
		 *  @param phaseType Specific touch phase.
		 * 
		 *  @see com.firefly.core.consts.TouchType */		
		public function TouchData(x:Number=NaN, y:Number=NaN, phaseType:String=TouchType.BEGAN)
		{
			_x = x;
			_y = y;
			_phase = phaseType;
		}
		
		/** Touch x axis position. */		
		public function get x():Number { return _x; }
		public function set x(value:Number):void { _x = value; }
		
		/** Touch y axis position. */		
		public function get y():Number { return _y; }
		public function set y(value:Number):void { _y = value; }
		
		/** Specific touch phase.
		 *  @see com.firefly.core.consts.TouchType */		
		public function get phase():String { return _phase; }
		public function set phase(value:String):void { _phase = value; }
		
		/** Clone current <code>TouchData</code> object.
		 *  @return New <code>TouchData</code> instance. */		
		public function clone():TouchData
		{
			var clone:TouchData = new TouchData();
			clone.x = _x;
			clone.y = _y;
			clone.phase = _phase;
			return clone;
		}
	}
}
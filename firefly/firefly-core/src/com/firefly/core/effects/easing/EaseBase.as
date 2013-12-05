// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.effects.easing
{
	public class EaseBase implements IEaser
	{
		private var _type:String;
		private var _fraction:Number;
		
		public function EaseBase(easeInFraction:Number = 0)
		{
			//this.type = type;
			this.fraction = easeInFraction;
		}
		
		public function get type():String { return _type; }
		public function set type(value:String):void { _type = value; }
		
		public function get fraction():Number { return _fraction; }
		public function set fraction(value:Number):void { _fraction = value; }

		public function ease(ratio:Number):Number
		{
			if (_fraction > 0 && _fraction <= 1)
				return easeInOut(ratio);
			else if (_fraction < 0 && _fraction >= -1)
				return easeOutIn(ratio);
			else
				return ratio;
				
			/*if (type == EaseType.EASE_IN)
				return easeIn(ratio);
			else if (type == EaseType.EASE_OUT)
				return easeOut(ratio);
			else if (type == EaseType.EASE_IN_OUT)
				return easeInOut(ratio);
			else if (type == EaseType.EASE_OUT_IN)
				return easeOutIn(ratio);
			else
				return ratio;*/
		}
		
		protected function easeIn(ratio:Number):Number
		{
			return ratio;
		}
		
		protected function easeOut(ratio:Number):Number
		{
			return ratio;
		}
		
		protected function easeInOut(ratio:Number):Number
		{
			return easeCombined(ratio, easeIn, easeOut);
		}
		
		protected function easeOutIn(ratio:Number):Number
		{
			return easeCombined(ratio, easeOut, easeIn);
		}
		
		protected function easeCombined(ratio:Number, startFunc:Function, endFunc:Function):Number
		{
			var easeInFraction:Number = fraction > 0 ? fraction : -fraction;
			var easeOutFraction:Number = 1 - easeInFraction;
			if (ratio <= easeInFraction && easeInFraction > 0)
				return easeInFraction * startFunc(ratio / easeInFraction);
			else
				return easeInFraction + easeOutFraction * endFunc((ratio - easeInFraction) / easeOutFraction);
		}
	}
}
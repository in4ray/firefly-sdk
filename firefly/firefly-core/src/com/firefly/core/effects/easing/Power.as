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
	public class Power extends EaseBase
	{
		private var _exponent:int;
		
		public function Power(fraction:Number=0.5, exponent:Number=2)
		{
			super(fraction);
			
			_exponent = exponent;
		}
		
		public function get exponent():int { return _exponent; }
		public function set exponent(value:int):void { _exponent = value; }

		override protected function easeIn(ratio:Number):Number
		{
			return Math.pow(ratio, exponent);
		}
		
		override protected function easeOut(ratio:Number):Number
		{
			return 1 - Math.pow((1 - ratio), exponent);
		}
	}
}
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
		public var exponent:int;
		
		public function Power(easeInFraction:Number = 0, exponent:Number = 2)
		{
			super(easeInFraction);
			
			this.exponent = exponent;
		}
		
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
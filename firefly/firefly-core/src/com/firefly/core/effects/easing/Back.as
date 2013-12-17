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
	public class Back extends EaseBase
	{
		public function Back(fraction:Number=0.5)
		{
			super(fraction);
		}
		
		override protected function easeIn(ratio:Number):Number
		{
			var s:Number = 1.70158;
			return Math.pow(ratio, 2) * ((s + 1.0) * ratio - s);
		}
		
		override protected function easeOut(ratio:Number):Number
		{
			var invRatio:Number = ratio - 1.0;            
			var s:Number = 1.70158;
			return Math.pow(invRatio, 2) * ((s + 1.0) * invRatio + s) + 1.0;
		}
	}
}
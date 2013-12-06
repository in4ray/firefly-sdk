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
	public class Circular extends EaseBase
	{
		public function Circular(fraction:Number = 0)
		{
			super(fraction);
		}
		
		override protected function easeIn(ratio:Number):Number
		{
			return -1 * (Math.sqrt(1 - ratio * ratio) - 1);
		}
		
		override protected function easeOut(ratio:Number):Number
		{
			var invRatio:Number = ratio - 1.0;
			return 1 * Math.sqrt(1 - invRatio * invRatio);
		}
	}
}
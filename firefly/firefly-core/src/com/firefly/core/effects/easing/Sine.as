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
	public class Sine extends EaseBase
	{
		public function Sine(fraction:Number = 0.5)
		{
			super(fraction);
		}
		
		override protected function easeIn(ratio:Number):Number
		{
			return 1 - Math.cos(ratio * Math.PI/2);
		}
		
		override protected function easeOut(ratio:Number):Number
		{
			return Math.sin(ratio * Math.PI/2);
		}
	}
}
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
	public class Bounce extends EaseBase
	{
		public function Bounce(fraction:Number = 0.5)
		{
			super(fraction);
		}
		
		override protected function easeIn(ratio:Number):Number
		{
			return 1.0 - easeOut(1.0 - ratio);
		}
		
		override protected function easeOut(ratio:Number):Number
		{
			var s:Number = 7.5625;
			var p:Number = 2.75;
			var l:Number;
			if (ratio < (1.0 / p))
			{
				l = s * Math.pow(ratio, 2);
			}
			else
			{
				if (ratio < (2.0 / p))
				{
					ratio -= 1.5 / p;
					l = s * Math.pow(ratio, 2) + 0.75;
				}
				else
				{
					if (ratio < 2.5 / p)
					{
						ratio -= 2.25 / p;
						l = s * Math.pow(ratio, 2) + 0.9375;
					}
					else
					{
						ratio -= 2.625 / p;
						l =  s * Math.pow(ratio, 2) + 0.984375;
					}
				}
			}
			return l;
		}
	}
}
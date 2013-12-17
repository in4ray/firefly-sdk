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
	public class Elastic extends EaseBase
	{
		public function Elastic(fraction:Number=0.5)
		{
			super(fraction);
		}
		
		override protected function easeIn(ratio:Number):Number
		{
			if (ratio == 0 || ratio == 1)
			{
				return ratio;
			}
			else
			{
				var p:Number = 0.3;
				var s:Number = p / 4.0;
				var invRatio:Number = ratio - 1;
				return -1.0 * Math.pow(2.0, 10.0 * invRatio) * Math.sin((invRatio - s) * (2.0 * Math.PI) / p);                
			}            
		}
		
		override protected function easeOut(ratio:Number):Number
		{
			if (ratio == 0 || ratio == 1) 
			{
				return ratio;
			}
			else
			{
				var p:Number = 0.3;
				var s:Number = p / 4.0;                
				return Math.pow(2.0, -10.0 * ratio) * Math.sin((ratio - s) * (2.0 * Math.PI) / p) + 1;                
			}            
		}
	}
}
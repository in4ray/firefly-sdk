// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.effects.easing
{
	/** The Bounce class defines two easing functions for using in animaions. This class 
	 *  implements bouncing motion, similar to a ball falling and bouncing on a floor with 
	 *  several decaying rebounds.
	 *  @see com.firefly.core.effects.easing.EaseBase */
	public class Bounce extends EaseBase
	{
		/** Constructor.
		 *  @param fraction The value that represents which easing need to use. The default value is 0.5, 
		 *  which eases in for the first half of the time (from 0 to 0.5) and eases out or the last time
		 *  (from 0.5 to 1). In case need revert easing from out to in, just set 0.5. */
		public function Bounce(fraction:Number=0.5)
		{
			super(fraction);
		}
		
		/** The function starts the bounce motion slowly and then accelerates motion as it executes.
		 *  @param ratio The ratio elapsed of the easing in phase of the animation, between 0.0 and 1.0.
		 *  @return The modified value of the easing in phase of the animation. */
		override protected function easeIn(ratio:Number):Number
		{
			return 1.0 - easeOut(1.0 - ratio);
		}
		
		/** The function starts the bounce motion fast and then decelerates motion as it executes.
		 *  @param ratio The ratio elapsed of the easing out phase of the animation, between 0.0 and 1.0.
		 *  @return The modified value of the easing out phase of the animation. */
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
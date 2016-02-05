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
	/** The Elastic class defines two easing functions using in animations, where the motion is 
	 *  defined by an exponentially decaying sine wave.
	 *  @see com.firefly.core.effects.easing.EaseBase */
	public class Elastic extends EaseBase
	{
		/** Constructor.
		 *  @param fraction The value that represents which easing need to use. The default value is 0.5, 
		 *  which eases in for the first half of the time (from 0 to 0.5) and eases out or the last time
		 *  (from 0.5 to 1). In case need revert easing from out to in, just set 0.5. */
		public function Elastic(fraction:Number=0.5)
		{
			super(fraction);
		}
		
		/** The function starts motion slowly and then accelerates motion as it executes.
		 *  @param ratio The ratio elapsed of the easing in phase of the animation, between 0.0 and 1.0.
		 *  @return The modified value of the easing in phase of the animation. */
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
		
		/** The function starts motion fast and then decelerates motion as it executes.
		 *  @param ratio The ratio elapsed of the easing out phase of the animation, between 0.0 and 1.0.
		 *  @return The modified value of the easing out phase of the animation. */
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
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
	/** The Elastc class defines two easing functions for using in animaions. This class 
	 *  implements motion, where the motion is defined by a sine wave.
	 *  @see com.firefly.core.effects.easing.EaseBase */
	public class Sine extends EaseBase
	{
		/** Constructor.
		 *  @param fraction The value that represents which easing need to use. The default value is 0.5, 
		 *  which eases in for the first half of the time (from 0 to 0.5) and eases out or the last time
		 *  (from 0.5 to 1). In case need revert easing from out to in, just set 0.5. */
		public function Sine(fraction:Number=0.5)
		{
			super(fraction);
		}
		
		/** The function starts motion from zero velocity, and then accelerates motion as it executes.
		 *  @param ratio The ratio elapsed of the easing in phase of the animation, between 0.0 and 1.0.
		 *  @return The modified value of the easing in phase of the animation. */
		override protected function easeIn(ratio:Number):Number
		{
			return 1 - Math.cos(ratio * Math.PI/2);
		}
		
		/** The function starts motion fast, and then decelerates motion to a zero velocity as it executes.
		 *  @param ratio The ratio elapsed of the easing out phase of the animation, between 0.0 and 1.0.
		 *  @return The modified value of the easing out phase of the animation. */
		override protected function easeOut(ratio:Number):Number
		{
			return Math.sin(ratio * Math.PI/2);
		}
	}
}
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
	/** The Back class defines two easing functions for using in animations.
	 *  @see com.firefly.core.effects.easing.EaseBase */
	public class Back extends EaseBase
	{
		/** Constructor.
		 *  @param fraction The value that represents which easing need to use. The default value is 0.5, 
		 *  which eases in for the first half of the time (from 0 to 0.5) and eases out or the last time
		 *  (from 0.5 to 1). In case need revert easing from out to in, just set 0.5. */
		public function Back(fraction:Number=0.5)
		{
			super(fraction);
		}
		
		/** The function starts the motion by backtracking and then reversing direction 
		 *  and moving toward the target.
		 *  @param ratio The ratio elapsed of the easing in phase of the animation, between 0.0 and 1.0.
		 *  @return The modified value of the easing in phase of the animation. */
		override protected function easeIn(ratio:Number):Number
		{
			var s:Number = 1.70158;
			return Math.pow(ratio, 2) * ((s + 1.0) * ratio - s);
		}
		
		/** The function starts the motion by moving towards the target, overshooting it slightly, 
		 *  and then reversing direction back toward the target.
		 *  @param ratio The ratio elapsed of the easing out phase of the animation, between 0.0 and 1.0.
		 *  @return The modified value of the easing out phase of the animation. */
		override protected function easeOut(ratio:Number):Number
		{
			var invRatio:Number = ratio - 1.0;            
			var s:Number = 1.70158;
			return Math.pow(invRatio, 2) * ((s + 1.0) * invRatio + s) + 1.0;
		}
	}
}
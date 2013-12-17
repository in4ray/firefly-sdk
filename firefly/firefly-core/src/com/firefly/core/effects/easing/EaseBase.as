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
	/** The EaseBase class is the base class that provide basic easing capability. */
	public class EaseBase implements IEaser
	{
		private var _type:String;
		private var _fraction:Number;
		
		/** Constructor.
		 *  @param fraction The value that represents which easing need to use. The default value is 0.5, 
		 *  which eases in for the first half of the time (from 0 to 0.5) and eases out or the last time
		 *  (from 0.5 to 1). In case need revert easing from out to in, just set 0.5. */
		public function EaseBase(fraction:Number=0.5)
		{
			_fraction = fraction;
		}
		
		/** The value that represents which easing need to use. In case need use <code>in-out</code> easing set 0.5 value.
		 *  If need use <code>out-in</code> easing set -0.5. For <code>in</code> easing set 1 value and for <code>out</code>
		 *  easing set -1 value. <p>Valid value is between -1.0 and 1.0.</p>
		 *
		 *  @default 0.5 */
		public function get fraction():Number { return _fraction; }
		public function set fraction(value:Number):void { _fraction = value; }

		/** @inheritDoc */
		public function ease(ratio:Number):Number
		{
			if (_fraction >= 0)
				return easeInOut(ratio);
			else
				return easeOutIn(ratio);
		}
		
		/** Returns a value that represents the eased ratio during the ease in phase of the animation.
		 *  @param ratio The ratio elapsed of the easing in phase of the animation, between 0.0 and 1.0.
		 *  @return The modified value of the easing in phase of the animation. */
		protected function easeIn(ratio:Number):Number
		{
			return ratio;
		}
		
		/** Returns a value that represents the eased ratio during the ease out phase of the animation.
		 *  @param ratio The ratio elapsed of the easing out phase of the animation, between 0.0 and 1.0.
		 *  @return The modified value of the easing out phase of the animation. */
		protected function easeOut(ratio:Number):Number
		{
			return ratio;
		}
		
		/** @private */
		protected function easeInOut(ratio:Number):Number
		{
			return easeCombined(ratio, easeIn, easeOut);
		}
		
		/** @private */
		protected function easeOutIn(ratio:Number):Number
		{
			return easeCombined(ratio, easeOut, easeIn);
		}
		
		/** @private */
		protected function easeCombined(ratio:Number, startFunc:Function, endFunc:Function):Number
		{
			var easeInFraction:Number = fraction >= 0 ? fraction : -fraction;
			var easeOutFraction:Number = 1 - easeInFraction;
			if (ratio <= easeInFraction && easeInFraction > 0)
				return easeInFraction * startFunc(ratio / easeInFraction);
			else
				return easeInFraction + easeOutFraction * endFunc((ratio - easeInFraction) / easeOutFraction);
		}
	}
}
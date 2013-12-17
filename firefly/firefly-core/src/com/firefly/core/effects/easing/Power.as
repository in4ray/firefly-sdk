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
	/** The Bounce class defines two easing functions for using in animaions. This class 
	 *  implements the easing functionality using a polynomial expression. The rate of acceleration 
	 *  and deceleration is based on the exponent property. The higher the value of the exponent.
	 *  @see com.firefly.core.effects.easing.EaseBase */
	public class Power extends EaseBase
	{
		private var _exponent:int;
		
		/** Constructor.
		 *  @param fraction The value that represents which easing need to use. The default value is 0.5, 
		 *  which eases in for the first half of the time (from 0 to 0.5) and eases out or the last time
		 *  (from 0.5 to 1). In case need revert easing from out to in, just set 0.5. 
		 *  @param exponent The exponent value used in the easing calculation. */
		public function Power(fraction:Number=0.5, exponent:Number=2)
		{
			super(fraction);
			
			_exponent = exponent;
		}
		
		/** The exponent used in the easing calculation. The higher the value of the exponent property, 
		 *  the greater the acceleration and deceleration. E.g. to get quadratic easing, set exponent to 2,
		 *  to get cubic easing, set exponent to 3, to get quartic easing, set exponent to 4 etc. */
		public function get exponent():int { return _exponent; }
		public function set exponent(value:int):void { _exponent = value; }

		/** The function starts motion slowly, and then accelerates motion as it executes.
		 *  @param ratio The ratio elapsed of the easing in phase of the animation, between 0.0 and 1.0.
		 *  @return The modified value of the easing in phase of the animation. */
		override protected function easeIn(ratio:Number):Number
		{
			return Math.pow(ratio, exponent);
		}
		
		/** The function starts motion fast, and then decelerates motion as it executes.
		 *  @param ratio The ratio elapsed of the easing out phase of the animation, between 0.0 and 1.0.
		 *  @return The modified value of the easing out phase of the animation. */
		override protected function easeOut(ratio:Number):Number
		{
			return 1 - Math.pow((1 - ratio), exponent);
		}
	}
}
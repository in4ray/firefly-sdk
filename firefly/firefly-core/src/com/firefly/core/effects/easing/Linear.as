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
	/** The Linear class defines an easing with three phases: acceleration, uniform motion,
	 *  and deceleration. As the animation starts it accelerates through the period specified 
	 *  by the <code>easeInFraction</code> property, it  then uses uniform (linear) motion 
	 *  through the next phase, and finally decelerates until the end during the period specified
	 *  by the <code>easeOutFraction</code> property. */
	public class Linear implements IEaser
	{
		/** @private */
		private var _easeInFraction:Number;
		/** @private */
		private var _easeOutFraction:Number;
		
		/** Constructor.
		 *  @param easeInFraction The fraction of the overall duration in the acceleration phase, 
		 *  between 0.0 and 1.0.
		 *  @param easeOutFraction The fraction of the overall duration in the deceleration phase,
		 *  between 0.0 and 1.0. */
		public function Linear(easeInFraction:Number=0, easeOutFraction:Number=0)
		{
			_easeInFraction = easeInFraction;
			_easeOutFraction = easeOutFraction;
		}
		
		/** The fraction of the overall duration in the acceleration phase. The values of the 
		 *  <code>easeOutFraction</code> property and <code>easeInFraction</code> property must 
		 *  satisfy the equation <code>easeOutFraction + easeInFraction &lt;= 1</code>.
		 *  <p>Valid value is between -1.0 and 1.0.</p> 
		 * 
		 *  @default 0 */
		public function get easeInFraction():Number { return _easeInFraction; }
		public function set easeInFraction(value:Number):void { _easeInFraction = value; }
		
		/** The fraction of the overall duration in the deceleration phase. The values of the 
		 *  <code>easeOutFraction</code> property and <code>easeInFraction</code> property must 
		 *  satisfy the equation <code>easeOutFraction + easeInFraction &lt;= 1</code>.
		 *  <p>Valid value is between -1.0 and 1.0.</p> 
		 * 
		 *  @default 0 */
		public function get easeOutFraction():Number { return _easeOutFraction; }
		public function set easeOutFraction(value:Number):void { _easeOutFraction = value; }
		
		/** @inheritDoc */
		public function ease(ratio:Number):Number
		{
			if (easeInFraction == 0 && easeOutFraction == 0)
				return ratio;
			
			var runRate:Number = 1 / (1 - easeInFraction/2 - easeOutFraction/2);
			if (ratio < easeInFraction)
				return ratio * runRate * (ratio / easeInFraction) / 2;
			if (ratio > (1 - easeOutFraction))
			{
				var decTime:Number = ratio - (1 - easeOutFraction);
				var decProportion:Number = decTime / easeOutFraction;
				return runRate * (1 - easeInFraction/2 - easeOutFraction +
					decTime * (2 - decProportion) / 2);
			}
			return runRate * (ratio - easeInFraction/2);
		}
	}
}
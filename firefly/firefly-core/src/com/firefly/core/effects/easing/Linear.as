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
	public class Linear implements IEaser
	{
		private var _easeInFraction:Number;
		private var _easeOutFraction:Number;
		
		public function Linear(easeInFraction:Number = 0, easeOutFraction:Number = 0)
		{
			this.easeInFraction = easeInFraction;
			this.easeOutFraction = easeOutFraction;
		}
		
		public function get easeInFraction():Number { return _easeInFraction; }
		public function set easeInFraction(value:Number):void { _easeInFraction = value; }
		
		public function get easeOutFraction():Number { return _easeOutFraction; }
		public function set easeOutFraction(value:Number):void { _easeOutFraction = value; }
		
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
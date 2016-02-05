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
	/** The IEaser interface should be implemented by classes that provide easing
	 *  functionality for the Animation class. 
	 *  
	 *  @see com.firefly.core.effects.easing.EaseBase
	 *  @see com.firefly.core.effects.easing.Linear
	 *  @see com.firefly.core.effects.easing.StarlingEaser
	 *  @see com.firefly.core.effects.Animation */
	public interface IEaser
	{
		/** Takes the ratio representing the elapsed duration value of an animation
		 *  and returns a modified value by ease function. A value is between 0.0 to 1.0. 
		 *  @param ratio The elapsed ratio of an animation.
		 *  @return The modified value by ease function. */
		function ease(ratio:Number):Number;
	}
}
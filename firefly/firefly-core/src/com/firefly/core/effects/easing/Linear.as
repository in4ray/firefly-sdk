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
		public function Linear()
		{
		}
		
		public function ease(ratio:Number):Number
		{
			return ratio;
		}
	}
}
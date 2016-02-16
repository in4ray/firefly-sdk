// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.components
{
	import starling.display.Quad;
	
	/** A Quad represents a rectangle with a uniform color or a color gradient. Also added 
	 *  additional possibility to set alpha value for the quad.*/	
	public class Quad extends starling.display.Quad
	{
		public function Quad(color:uint=16777215, alpha:Number = 1)
		{
			super(1, 1, color);
			
			this.alpha = alpha;
		}
	}
}
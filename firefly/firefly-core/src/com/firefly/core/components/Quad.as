package com.firefly.core.components
{
	import starling.display.Quad;
	
	public class Quad extends starling.display.Quad
	{
		public function Quad(color:uint=16777215, alpha:Number = 1)
		{
			super(1, 1, color);
			
			this.alpha = alpha;
		}
	}
}
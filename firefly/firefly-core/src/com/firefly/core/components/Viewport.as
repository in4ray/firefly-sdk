package com.firefly.core.components
{
	import com.firefly.core.display.IViewport;
	
	public class Viewport extends Container implements IViewport
	{
		private var _moveMultiplier:Number;
		
		public function Viewport(moveMultiplier:Number=1)
		{
			super();
			
			_moveMultiplier = moveMultiplier;
		}
		
		public function get moveMultiplier():Number { return _moveMultiplier; }
		public function set moveMultiplier(val:Number):void { _moveMultiplier = val; }
	}
}
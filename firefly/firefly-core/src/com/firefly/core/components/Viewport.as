package com.firefly.core.components
{
	import com.firefly.core.display.IViewport;
	
	public class Viewport extends Component implements IViewport
	{
		private var _hFraction:Number;
		private var _vFraction:Number;
		
		public function Viewport(hFraction:Number=1, vFraction:Number=1)
		{
			super();
			
			_hFraction = hFraction;
			_vFraction = vFraction;
		}
		
		public function get hFraction():Number { return _hFraction; }
		public function set hFraction(value:Number):void { _hFraction = value; }
		
		public function get vFraction():Number { return _vFraction; }
		public function set vFraction(value:Number):void { _vFraction = value; }
	}
}
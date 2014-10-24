package com.firefly.core.components
{
	import com.firefly.core.display.IViewport;
	
	public class Viewport extends Component implements IViewport
	{
		private var _id:String;
		private var _hFraction:Number;
		private var _vFraction:Number;
		
		public function Viewport(id:String, hFraction:Number=1, vFraction:Number=1)
		{
			super();
			
			_id = id;
			_hFraction = hFraction;
			_vFraction = vFraction;
		}
		
		public function get id():String { return _id; }
		public function set id(value:String):void { _id = value; }
		
		public function get hFraction():Number { return _hFraction; }
		public function set hFraction(value:Number):void { _hFraction = value; }
		
		public function get vFraction():Number { return _vFraction; }
		public function set vFraction(value:Number):void { _vFraction = value; }
	}
}
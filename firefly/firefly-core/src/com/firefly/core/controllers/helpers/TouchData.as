package com.firefly.core.controllers.helpers
{
	import com.firefly.core.consts.TouchType;

	public class TouchData
	{
		private var _x:Number;
		private var _y:Number;
		private var _phase:String;
		
		public function TouchData(x:Number=NaN, y:Number=NaN, phaseType:String=TouchType.BEGAN)
		{
			_x = x;
			_y = y;
			_phase = phaseType;
		}
		
		public function get x():Number { return _x; }
		public function set x(value:Number):void { _x = value; }
		public function get y():Number { return _y; }
		public function set y(value:Number):void { _y = value; }
		public function get phase():String { return _phase; }
		public function set phase(value:String):void { _phase = value; }
		
		public function clone():TouchData
		{
			var clone:TouchData = new TouchData();
			clone.x = _x;
			clone.y = _y;
			clone.phase = _phase;
			return clone;
		}
	}
}
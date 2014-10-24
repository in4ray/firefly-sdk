package com.firefly.core.controllers.helpers
{
	import com.firefly.core.consts.TouchType;

	public class TouchData
	{
		private var _x:Number;
		private var _y:Number;
		private var _phaseType:String;
		
		public function TouchData(x:Number=NaN, y:Number=NaN, phaseType:String=TouchType.BEGIN)
		{
			_x = x;
			_y = y;
			_phaseType = phaseType;
		}
		
		public function get x():Number { return _x; }
		public function set x(value:Number):void { _x = value; }
		public function get y():Number { return _y; }
		public function set y(value:Number):void { _y = value; }
		public function get phaseType():String { return _phaseType; }
		public function set phaseType(value:String):void { _phaseType = value; }
		
		public function clone():TouchData
		{
			var clone:TouchData = new TouchData();
			clone.x = _x;
			clone.y = _y;
			clone.phaseType = _phaseType;
			return clone;
		}
	}
}
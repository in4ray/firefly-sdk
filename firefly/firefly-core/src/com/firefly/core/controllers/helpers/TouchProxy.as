package com.firefly.core.controllers.helpers
{
	import com.firefly.core.display.ITouch;
	
	import starling.events.Touch;
	
	public class TouchProxy implements ITouch
	{
		private var _touch:Touch;
		private var _x:Number;
		private var _y:Number;
		private var _phaseType:String;
		
		public function TouchProxy()
		{
		}
		
		public function get x():Number { return _x; }
		public function set x(val:Number):void { _x = val; }
		public function get y():Number { return _y; }
		public function set y(val:Number):void { _y = val; }
		public function get phaseType():String { return _phaseType; }
		public function set phaseType(val:String):void { _phaseType = val; }
		
		public function get touch():Touch { return _touch; }
		public function set touch(value:Touch):void
		{ 
			_touch = value;
			
			if (value)
			{
				_x = value.globalX; 
				_y = value.globalY; 
				_phaseType = value.phase; 
			}
		}
		
		public function clone():ITouch
		{
			var clone:TouchProxy = new TouchProxy();
			clone.touch = _touch;
			return clone;
		}
	}
}
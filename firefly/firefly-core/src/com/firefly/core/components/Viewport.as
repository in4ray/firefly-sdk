package com.firefly.core.components
{
	import com.firefly.core.display.IViewport;
	
	public class Viewport extends Container implements IViewport
	{
		private var _id:String;
		private var _moveMultiplier:Number;
		
		public function Viewport(id:String, moveMultiplier:Number=1)
		{
			super();
			
			_id = id;
			_moveMultiplier = moveMultiplier;
		}
		
		public function get id():String { return _id; }
		public function set id(val:String):void { _id = val; }
		
		public function get moveMultiplier():Number { return _moveMultiplier; }
		public function set moveMultiplier(val:Number):void { _moveMultiplier = val; }
	}
}
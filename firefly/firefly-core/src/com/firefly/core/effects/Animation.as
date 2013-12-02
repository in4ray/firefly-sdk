package com.firefly.core.effects
{
	import starling.animation.Juggler;
	
	public class Animation implements IAnimation
	{
		private var _juggler:Juggler;
		private var _target:Object;
		private var _duration:Number;
		private var _delay:Number;
		private var _loop:Boolean;
		
		private var _isPlaying:Boolean;
		private var _isPause:Boolean;
		
		public function Animation(target:Object, duration:Number)
		{
			this.target = target;
			this.duration = duration;
		}
		
		public function get target():Object { return _target; }
		public function set target(value:Object):void { _target = value; }
		
		public function get duration():Number { return _duration; }
		public function set duration(value:Number):void { _duration = value; }
		
		public function get delay():Number { return _delay; }
		public function set delay(value:Number):void { _delay = value; }
		
		public function get isPlaying():Boolean { return _isPlaying; }
		public function get isPause():Boolean { return _isPause; }
		
		public function get loop():Boolean { return _loop; }
		public function set loop(value:Boolean):void { _loop = value; }
		
		public function get transition():String
		{
			return null;
		}
		
		public function set transition(value:String):void
		{
		}
		
		public function get disposeOnComplete():Boolean
		{
			return false;
		}
		
		public function set disposeOnComplete(value:Boolean):void
		{
		}
		
		public function get juggler():Juggler
		{
			return null;
		}
		
		public function set juggler(value:Juggler):void
		{
		}
		
		public function play():void
		{
		}
		
		public function pause():void
		{
		}
		
		public function resume():void
		{
		}
		
		public function stop():void
		{
		}
		
		public function end():void
		{
		}
		
		public function dispose():void
		{
		}
		
		public function isDefaultJuggler():Boolean
		{
			return false;
		}
	}
}
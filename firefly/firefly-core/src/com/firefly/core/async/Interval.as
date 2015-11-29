package com.firefly.core.async
{
	import com.firefly.core.Firefly;
	import com.firefly.core.utils.Log;
	
	import flash.utils.Dictionary;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import starling.animation.IAnimatable;
	import starling.animation.Juggler;

	public class Interval
	{
		private var _interval:Number;
		private var _repeatCount:int;
		private var _juggler:Juggler;
		private var _repeatJuggler:IAnimatable;
		private var _callbackFuncs:Dictionary;
		private var _intervalId:uint;
		
		/** Constructor.
		 * 	@param interval Callback interval in seconds.
		 * 	@param repeatCount Repeat count of the callback.
		 * 	@param juggler Juggler object. If not specified then <code>Firefly.current.juggler</code> will be used.
		 *  @param autostart Autostart calculation if repeat callback. */		
		public function Interval(interval:Number, repeatCount:int=0, juggler:Juggler=null, autostart:Boolean=true)
		{
			_interval = interval;
			_repeatCount = repeatCount;
			_juggler = juggler ? juggler : Firefly.current.juggler;
			_callbackFuncs = new Dictionary();
			
			if (autostart)
				start();
		}
		
		public function then(callback:Function, ...args):Interval
		{
			CONFIG::debug {
				if(_callbackFuncs.hasOwnProperty(callback))
					Log.warn("Callback function already added.");
			};
			
			_callbackFuncs[callback] = args;
			return this;
		}
		
		public function start():void
		{
			resume();
		}
		
		public function pause():void
		{
			if (_juggler)
			{
				_juggler.remove(_repeatJuggler);
				_repeatJuggler = null;
			}
			else
			{
				clearInterval(_intervalId);
			}
		}
		
		public function resume():void
		{
			if (_juggler)
				_repeatJuggler = _juggler.repeatCall(onRepeat, _interval, _repeatCount);
			else
				_intervalId = setInterval(onRepeat, _interval*1000);
		}
		
		public function cancel():void
		{
			if (_juggler)
			{
				_juggler.remove(_repeatJuggler);
				_juggler = null;
				_repeatJuggler = null;
			}
			else
			{
				clearInterval(_intervalId);
			}
			
			for (var key:* in _callbackFuncs)
			{
				delete _callbackFuncs[key];
			}
			_callbackFuncs = null;
		}
		
		private function onRepeat():void
		{
			for (var func:* in _callbackFuncs)
			{
				func.apply(null, _callbackFuncs[func]);
			}
			
			if (_repeatCount != 0)
			{
				_repeatCount--;
				if (_repeatCount == 0) cancel();
			}
		}
	}
}
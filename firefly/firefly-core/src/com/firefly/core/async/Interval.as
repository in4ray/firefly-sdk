// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.async
{
	import com.firefly.core.Firefly;
	import com.firefly.core.utils.Log;
	
	import flash.utils.Dictionary;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import starling.animation.Juggler;

	/** Class that used to call function by defiened interval. In this class uses Starling 
	 *  juggler for calling function by interval. */
	public class Interval
	{
		private var _interval:Number;
		/** @private */
		private var _repeatCount:int;
		/** @private */
		private var _juggler:Juggler;
		/** @private */
		//private var _repeatJuggler:IAnimatable;
		/** @private */
		private var _callbackFuncs:Dictionary;
		/** @private */
		private var _intervalId:uint;
		
		/** Constructor.
		 * 	@param interval Interval in seconds whereupon callback function will be calling.
		 * 	@param repeatCount Repeat count of the callback. By default the value is <code>0</code> 
		 *  	   what means callback function will be called continually.
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

		/** Register callback function for interval calls.
		 * 
		 *  <pre>function callbackFunction(arg1:Object, arg2:Object, ...):void</pre>
		 * 
		 * @param callback Function that will be called.
		 * @param args Additional arguments that will be passed after 
		 * 			   requared parameters into function.
		 * @return Itself.
		 * 
	 *  @example The following code shows how to call function by interval:
	 *  <listing version="3.0">
	 *************************************************************************************
function main():void
{
	 var interval:Interval = new Interval(0.6, 0, Starling.juggler, false);
	 interval.then(callbackFunction);
	 interval.start();
	 
	 Future.delay(2).then(interval.pause);
	 Future.delay(3).then(interval.resume);
}
&#xA0;
function callbackFunction():void
{
	 trace("Interval call after 0.6 sec.");
}
	 *************************************************************************************
	 *  </listing> */		
		public function then(callback:Function, ...args):Interval
		{
			CONFIG::debug {
				if(_callbackFuncs.hasOwnProperty(callback))
					Log.warn("Callback function already added.");
			};
			
			_callbackFuncs[callback] = args;
			return this;
		}
		
		/** This function starts interval calculation.
		 *  @return Itself. */		
		public function start():Interval
		{
			resume();
			return this;
		}
		
		/** This function pauses interval calculation.
		 *  @return Itself. */
		public function pause():Interval
		{
			if (_juggler)
			{
				_juggler.removeByID(_intervalId);
				//_juggler.remove(_repeatJuggler);
				//_repeatJuggler = null;
			}
			else
			{
				clearInterval(_intervalId);
			}
			return this;
		}
		
		/** This function resumes interval calculation.
		 *  @return Itself. */
		public function resume():Interval
		{
			if (_juggler)
				_intervalId = _juggler.repeatCall(onRepeat, _interval, _repeatCount);
			else
				_intervalId = setInterval(onRepeat, _interval*1000);
			
			return this;
		}
		
		/** This function cancels interval calculation. */
		public function cancel():void
		{
			if (_juggler)
			{
				/*_juggler.remove(_repeatJuggler);
				_juggler = null;
				_repeatJuggler = null;*/
				
				_juggler.removeByID(_intervalId);
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
		
		/** @private */		
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
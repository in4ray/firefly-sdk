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
	import com.firefly.core.firefly_internal;
	import com.firefly.core.async.helpers.Progress;
	import com.firefly.core.cache.CacheFactory;
	import com.firefly.core.utils.Log;
	
	import starling.animation.Juggler;

	/** Class that can make async callbacks with argumets.
	 *  @see com.firefly.core.async.Completer */	
	public class Future
	{
		/** @private */
		firefly_internal static var pool:CacheFactory = new CacheFactory();
		
		/** @private */
		private var _completeCallback:Function;
		/** @private */
		private var _completeArgs:Array;
		/** @private */
		private var _errorCallback:Function;
		/** @private */
		private var _errorArgs:Array;
		/** @private */
		private var _progressCallback:Function;
		/** @private */
		private var _progressArgs:Array;
		/** @private */
		private var _currentProgress:Progress;
		/** @private */
		private var _active:Boolean;
		
		/** Register callback function for complete event.
		 * 
		 *  <pre>function callbackFunction(arg1:Object, arg2:Object, ...):void</pre>
		 * 
		 *  @param callback Function that will be called.
		 *  @param args Additional arguments that will be passed after 
		 * 			    requared parameters into function.
		 *  @return Itself.
		 * 
		 *  @example The following code sets async callback function:
		 *  <listing version="3.0">
*************************************************************************************
function main():void
{
	var completer:Completer = new Completer();
	completer.future.then(callbackFunction, 10);
	completer.complete("Argument from completer");
}
&#xA0;
function callbackFunction(arg1:String, arg2:int):void
{
	trace("arg1: " + arg1 + " arg2: " + arg2);
}
*************************************************************************************
		 * </listing> */		
		public function then(callback:Function, ...args):Future
		{
			CONFIG::debug {
				if(_completeCallback != null)
					Log.warn("Future already initialized.");
			};
			
			_completeCallback = callback;
			_completeArgs = args;
			_active = true;
			
			return this;
		}

		/** Register callback function for error event.
		 * 
		 *  <pre>function callbackFunction(arg1:Object, arg2:Object, ...):void</pre>
		 * 
		 *  @param callback Function that will be called.
		 *  @param args Additional arguments that will be passed after 
		 * 			    requared parameters into function.
		 *  @return Itself.
		 * 
		 *  @example The following code sets async callback function:
		 *  <listing version="3.0">
*************************************************************************************
function main():void
{
	var completer:Completer = new Completer();
	completer.future.error(callbackFunction, 10);
	completer.fail("Argument from completer");
}
&#xA0;
function callbackFunction(arg1:String, arg2:int):void
{
	trace("arg1: " + arg1 + " arg2: " + arg2);
}
*************************************************************************************
		* </listing> */	
		public function error(callback:Function, ...args):Future
		{
			CONFIG::debug {
				if(_errorCallback != null)
					Log.warn("Future already initialized.");
			};
			
			_errorCallback = callback;
			_errorArgs = args;
			_active = true;
			
			return this;
		}
		
		/** Register callback function for progress event. 
		 * 
		 *  <pre>function callbackFunction(ratio:Number, arg1:Object, arg2:Object, ...):void</pre>
		 * 
		 *  @param callback Function that will be called (first argument is progress ratio between 0 and 1).
		 *  @param args Additional arguments that will be passed after 
		 *  			   ratio into function.
		 *  @return Itself.
		 * 
		 *  @example The following code sets progress callback function:
		 *  <listing version="3.0">
*************************************************************************************
function main():void
{
	var group:GroupCompleter = new GroupCompleter(new DelayedCompleter(1).future, new DelayedCompleter(2).future);
	completer.future.progress(onProgressFunction, 10);
}
&#xA0;
function onProgressFunction(ratio:Number, arg1:String):void
{
	trace("Progress: " + ratio~~100 + "% arg1: " + arg1);
}
*************************************************************************************
		 *  </listing> */		
		public function progress(callback:Function, ...args):Future
		{
			CONFIG::debug {
				if(_progressCallback != null)
					Log.warn("Future already initialized.");
			};
			
			_progressCallback = callback;
			_progressArgs = args;
			_active = true;
			
			return this;
		}
		
		/** Get current progress or null if no progress. */		
		firefly_internal function get currentProgress():Progress
		{
			return _currentProgress;
		}
		
		/** Call complete callback function.  
		 *  @param args Requared arguments. */		
		firefly_internal function complete(...args):void
		{
			if(_completeCallback != null)
				_completeCallback.apply(null, args.concat(_completeArgs));
			
			firefly_internal::release();
		}
		
		/** Call progress callback function.  
		 *  @param progress Progress value object. */		
		firefly_internal function sendProgress(progress:Progress):void
		{
			_currentProgress = progress;
			
			if(_progressCallback != null && progress.current > 0)
				_progressCallback.apply(null, [progress.current/progress.total].concat(_progressArgs));
		}
		
		/** Call error callback function.  
		 *  @param args Requared arguments. */		
		firefly_internal function fail(...args):void
		{
			if(_errorCallback != null)
				_errorCallback.apply(null, args.concat(_errorArgs));
			
			firefly_internal::release();
		}
		
		/** Release callback data. */		
		firefly_internal function release():void
		{
			if (_active) 
			{
				_completeCallback = null;
				_completeArgs = null;
				_progressCallback = null;
				_progressArgs = null;
				_errorCallback = null;
				_errorArgs = null;
				_active = false;
				
				firefly_internal::pool.cache(this);
			}
		}
		
		// ########################### STATIC ########################## //
		/** Group all Futures in one and call progress function for each complition.
		 *  @param future First Future object.
		 *  @param args Rest Futures objects.
		 *  @return Composed Future object.
		 * 
		 *  @see com.firefly.core.async.FutureGroup */		
		public static function forEach(future:Future, ...args):Future
		{
			var group:GroupCompleter = new GroupCompleter();
			group.append.apply(null, [future].concat(args));
			return group.future;
		}
		
		/** Create Future that will be triggered after some delay.
		 *  @param delay Delay in sec.
		 *  @param juggler Juggler object.
		 *  @return Future object
		 *  @see com.firefly.core.async.DelayedCompleter */			
		public static function delay(delay:Number, juggler:Juggler = null):Future
		{
			return new DelayedCompleter(delay, juggler).future;
		}
		
		/** Create Future that will be triggered on next frame.
		 *  @return Future object
		 *  @see com.firefly.core.async.NextFrameCompleter */			
		public static function nextFrame():Future
		{
			return new NextFrameCompleter().future;
		}
	}
}
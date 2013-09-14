// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.async
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.async.helpers.Progress;
	
	use namespace firefly_internal;
	
	/** Class that used to manually trigger Future objects.
	 * 
	 *  @example The following code shows how to trigger Future objects:
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
 	trace("arg1: " + arg1 + " arg2 " + arg2);
 }
	 *************************************************************************************
	 *  </listing> */	
	public class Completer
	{		
		private var _future:Future;
		
		/** Constructor.
		 *  @param future Object to be triggered if null 
		 *  than it will be created automatically. */		
		public function Completer(future:Future = null)
		{
			_future = future;
		}
		
		/** Object to be triggered. */
		public function get future():Future 
		{ 
			if(!_future)
				_future = new Future();
			
			return _future; 
		}
		
		/** Send progress value. */		
		public function sendProgress(progress:Progress):void
		{
			future.sendProgress(progress);
		}
		
		/** Trigger Future object and relese it.
		 *  @param args Parameter to be send to Future object. */		
		public function complete(...args):void
		{
			if(_future)
				_future.complete.apply(null, args);
			
			release();
		}
		
		/** Release Future object. */		
		public function release():void
		{
			if(_future)
			{
				_future.release();
				_future = null;
			}
		}
	}
}
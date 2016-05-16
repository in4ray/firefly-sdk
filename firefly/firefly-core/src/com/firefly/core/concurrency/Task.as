// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.concurrency
{
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;

	/** Task class that contains information about function and arguments that 
	 *  needs to be performed by schedule. */	
	public class Task extends Completer
	{
		/** @private */
		private var _args:Array;
		/** @private */
		private var _func:Function;
		
		/** Constructor.
		 *  @param func Function to be performed by schedule.
		 *  @param args Argumentd to be passed into function. */		
		public function Task(func:Function, args:Array)
		{
			_func = func;
			_args = args;
		}
		
		/** Perform function. 
		 *  @return Future objact for callback. */		
		public function proceed():Future
		{
			if(_func != null)
				return _func.apply(null, _args);
			
			return null;
		}
		
		/** Release task object. */		
		override public function release():void
		{
			super.release();
			
			_func = null;
			_args = null;
		}
	}
}
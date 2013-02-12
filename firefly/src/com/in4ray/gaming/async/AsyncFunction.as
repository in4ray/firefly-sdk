// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.async
{
	[ExcludeClass]
	/**
	 * Value object for asynchronous operations. 
	 */	
	public class AsyncFunction
	{
		/**
		 * Constructor.
		 *  
		 * @param func Function to be called asynchronously
		 * @param params Parameters for function above.
		 */		
		public function AsyncFunction(func:Function, params:Array)
		{
			_params = params;
			_func = func;
		}
		
		private var _func:Function;
		
		/**
		 * Function to be called.
		 */
		public function get func():Function
		{
			return _func;
		}

		private var _params:Array;

		/**
		 * Parameters to be send to function.  
		 */		
		public function get params():Array
		{
			return _params;
		}
		
		/**
		 * Call function. 
		 */		
		public function call():void
		{
			_func.apply(null, _params);
		}
			
	}
}
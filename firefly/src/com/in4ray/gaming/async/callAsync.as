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
	import com.in4ray.gaming.core.SingletonLocator;
	
	/**
	 * Call function with params asynchronously.
	 * 
	 * @param func Function to ba called.
	 * @param params Parameters to be send into function above.
	 */	
	public function callAsync(func:Function, ...params):void
	{
		if(func != null)
		{		
			var manager:AsyncManager = SingletonLocator.getInstance(AsyncManager);
			
			manager.add(new AsyncFunction(func, params));
		}
	}
}
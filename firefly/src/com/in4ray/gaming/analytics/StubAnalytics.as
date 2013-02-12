// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.analytics
{
	import com.in4ray.gaming.core.SingletonLocator;

	/**
	 * Used as a stub to prevent sending any analytic events. 
	 */	
	public class StubAnalytics implements IAnalytics
	{
		/**
		 * Constructor. This class register itself in singleton locator for IAnalytics interface, 
		 * after instantiating you can access it by SingeltonLocator.getInstance(IAnalytics).
		 */		
		public function StubAnalytics()
		{
			SingletonLocator.register(IAnalytics, this);
		}
		
		/**
		 * @inheritDoc 
		 */		
		public function log(action:String, event:String):void
		{
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function send():void
		{
		}
	}
}
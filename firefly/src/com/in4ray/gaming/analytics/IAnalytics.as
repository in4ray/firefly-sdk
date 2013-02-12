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
	/**
	 * Analytics interface. Used to send events to server e.g. Google Analytics.
	 */	
	public interface IAnalytics
	{
		/**
		 * Log action.
		 *  
		 * @param action Name of action.
		 * @param label Label of action will be grouped on analytics server.
		 */		
		function log(action:String, event:String):void;
		
		/**
		 * Send cashed analytics to server if manual mode.
		 */
		function send():void;
	}
}
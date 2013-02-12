// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.components
{
	/**
	 * Interface for map container 
	 */	
	public interface IViewMap extends IVisualContainer
	{
		/**
		 * General map width in pixels. 
		 */		
		function get mapWidth():Number;
		
		/**
		 * General map height in pixels. 
		 */	
		function get mapHeight():Number;
		
		/**
		 * Current view port position by X-axis. 
		 */		
		function get viewPortX():Number;
		
		/**
		 * Current view port position by Y-axis. 
		 */
		function get viewPortY():Number;
	}
}
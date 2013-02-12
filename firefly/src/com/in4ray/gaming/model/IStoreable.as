// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.model
{
	/**
	 * Interface for classes that can be stored into shared objects. 
	 */	
	public interface IStoreable
	{
		/**
		 * Load data from shared object when game starts up. 
		 */		
		function load(data:Object):void;
		
		/**
		 * Save data into shared object when game exits. 
		 */		
		function save(data:Object):void;
		
		/**
		 * Load data from shared object when game recovers from hibernate. 
		 */		
		function wakeUp(data:Object):void;
		
		/**
		 * Save data into shared object when game goes into hibernate. 
		 */	
		function sleep(data:Object):void;
		
		/**
		 * Path to shared object.
		 */		
		function get path():String;
	}
}
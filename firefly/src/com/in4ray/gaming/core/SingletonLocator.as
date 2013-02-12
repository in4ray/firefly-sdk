// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.core
{
	import flash.utils.Dictionary;

	/**
	 * Helper manager to work with singletons. 
	 */	
	public class SingletonLocator
	{
		private static var singletons:Dictionary = new Dictionary();
	
		/**
		 * Get instance by class name. 
		 * @param className Class name.
		 * @return Registered instance.
		 */		
		public static function getInstance(className:Class):*
		{
			var result:Object = singletons[className];
			
			if(!result)
			{
				result = new className();
				singletons[className] = result;
			}
			
			return result;
		}
		
		/**
		 * Register instance. 
		 * @param className Class name, can be interface name.
		 * @param classInstance Instance to be used as singleton.
		 */		
		public static function register(className:Class, classInstance:*):void
		{
			var result:Object = singletons[className];
			
			if(!result)
			{
				singletons[className] = classInstance;
			}
		}
	}
}
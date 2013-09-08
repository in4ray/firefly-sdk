// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.utils
{
	import flash.utils.Dictionary;

	/**
	 * Helper manager to work with singletons. 
	 */	
	public class SingletonLocator
	{
		private static var _singletons:Dictionary = new Dictionary();
	
		/** Get instance by class name. 
		 *  @param className Class name.
		 *  @return Registered instance. */		
		public static function getInstance(className:Class, instance:*):*
		{
			var result:Object = _singletons[className];
			
			if(!result)
			{
				result = instance ?  instance : new className();
				_singletons[className] = result;
			}
			
			return result;
		}
		
		/** Register instance. 
		 *  @param className Class name, can be interface name.
		 *  @param classInstance Instance to be used as singleton. */		
		public static function register(className:Class, classInstance:*):void
		{
			var result:Object = _singletons[className];
			
			if(!result)
			{
				_singletons[className] = classInstance;
			}
		}
	}
}
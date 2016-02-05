// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.utils
{
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;

	/** Helper manager to work with singletons. */	
	public class SingletonLocator
	{
		private static var _singletons:Dictionary = new Dictionary();
	
		/** Get instance by class name. 
		 *  @param className Class name.
		 *  @param cArgs Constructor arguments.
		 *  @return Registered instance. */		
		public static function getInstance(className:Class, instance:*=null, ...cArgs):*
		{
			var result:Object = _singletons[className];
			
			if(!result)
			{
				if(!instance)
				{
					var factory:ClassFactory = new ClassFactory(className); 
					factory.cArgs = cArgs;
					instance = factory.newInstance();
				}
				result = instance;
				_singletons[className] = result;
			}
			
			return result;
		}
		
		/** Register instance. 
		 *  @param classInstance Instance to be used as singleton.
		 *  @param className Class name, can be interface name. */		
		public static function register(classInstance:*, className:Class=null):void
		{
			if(!className)
				className = getDefinitionByName(classInstance) as Class;
			
			var result:Object = _singletons[className];
			
			if(!result)
			{
				_singletons[className] = classInstance;
			}
		}
		
		/** Is class registered. 
		 *  @param className Class name, can be interface name. */		
		public static function isRegistered(className:Class):Boolean
		{
			return _singletons.hasOwnProperty(className);
		}
	}
}
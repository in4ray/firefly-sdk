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
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	/**
	 * Factory that create instances of class with specific properties and calling functions automatically. 
	 */	
	dynamic public class ClassFactory extends Proxy
	{
		
		/**
		 * Constructor.
		 *  
		 * @param classItem Class to be instantiated.
		 * @param cArgs Constructor arguments.
		 */		
		public function ClassFactory(className:Class = null, ...cArgs)
		{
			super();
			this.cArgs = cArgs;
			this.className = className;
		}
		
		/**
		 *  Class to be instantiated. 
		 */		
		public var className:Class;
		
		/**
		 * private 
		 */		
		private var creationFunc:Function;
		
		/**
		 * Create new instance of class. 
		 * @return Instance.
		 */		
		public function newInstance():*
		{
			var instance:Object = creationFunc();
			
			if(properties)
			{
				for each (var prop:PropertyProxy in properties) 
				{
					var property:* = prop.value;
					if(property is ClassFactory)
						property = (property as ClassFactory).newInstance();
					
					instance[prop.name.localName] = property; 
				}
			}
			
			if(functions)
			{
				for each (var func:FunctionProxy in functions) 
				{
					instance[func.name.localName].apply(null, func.parameters); 
				}
			}
			
			return instance;
		}
		
		/**
		 * @private
		 */
		private var _cArgs:Array;

		/**
		 * Constructor args. Max 10.
		 */
		public function get cArgs():Array
		{
			return _cArgs;
		}

		/**
		 * @private
		 */
		public function set cArgs(value:Array):void
		{
			_cArgs = value;
			
			creationFunc = this["createWithArg" + cArgs.length];
		}

		
		private var properties:Vector.<PropertyProxy>;
		private var functions:Vector.<FunctionProxy>;
		
		override flash_proxy function setProperty(name:*, value:*):void
		{
			if(!properties)
				properties = new Vector.<PropertyProxy>();
			properties.push(new PropertyProxy(name, value));
		}
		
		override flash_proxy function callProperty(name:*, ...parameters):*
		{
			if(!functions)
				functions = new Vector.<FunctionProxy>();
			
			functions.push(new FunctionProxy(name, parameters));
		}
		
		private function createWithArg0():Object
		{
			return new className();
		}
		
		private function createWithArg1():Object
		{
			return new className(cArgs[0]);
		}
		
		private function createWithArg2():Object
		{
			return new className(cArgs[0], cArgs[1]);
		}
		
		private function createWithArg3():Object
		{
			return new className(cArgs[0], cArgs[1], cArgs[2]);
		}
		
		private function createWithArg4():Object
		{
			return new className(cArgs[0], cArgs[1], cArgs[2], cArgs[3]);
		}
		
		private function createWithArg5():Object
		{
			return new className(cArgs[0], cArgs[1], cArgs[2], cArgs[3], cArgs[4]);
		}
		
		private function createWithArg6():Object
		{
			return new className(cArgs[0], cArgs[1], cArgs[2], cArgs[3], cArgs[4], cArgs[5]);
		}
		
		private function createWithArg7():Object
		{
			return new className(cArgs[0], cArgs[1], cArgs[2], cArgs[3], cArgs[4], cArgs[5], cArgs[6]);
		}
		
		private function createWithArg8():Object
		{
			return new className(cArgs[0], cArgs[1], cArgs[2], cArgs[3], cArgs[4], cArgs[5], cArgs[6], cArgs[7]);
		}
		
		private function createWithArg9():Object
		{
			return new new className(cArgs[0], cArgs[1], cArgs[2], cArgs[3], cArgs[4], cArgs[5], cArgs[6], cArgs[7], cArgs[8]);
		}
		
		private function createWithArg10():Object
		{
			return new className(cArgs[0], cArgs[1], cArgs[2], cArgs[3], cArgs[4], cArgs[5], cArgs[6], cArgs[7], cArgs[8], cArgs[9]);
		}
	}
}

class PropertyProxy
{
	public var name:QName;
	
	public var value:*;
	
	public function PropertyProxy(name:QName, value:*)
	{
		this.value = value;
		this.name = name;
	}
}

class FunctionProxy
{
	public var name:QName;
	
	public var parameters:Array;
	
	public function FunctionProxy(name:QName, parameters:Array)
	{
		this.parameters = parameters;
		this.name = name;
	}
}
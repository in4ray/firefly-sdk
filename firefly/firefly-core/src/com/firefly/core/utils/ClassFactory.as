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
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	/** Factory that create instances of class with specific properties and calling functions automatically. */	
	dynamic public class ClassFactory extends Proxy
	{	
		private var _creationFunc:Function;
		private var _cArgs:Array;
		private var _properties:Vector.<PropertyProxy>;
		private var _functions:Vector.<FunctionProxy>;
		
		/** Class to be instantiated. */		
		public var className:Class;
		
		/** Constructor.
		 *  @param classItem Class to be instantiated.
		 *  @param cArgs Constructor arguments. */		
		public function ClassFactory(className:Class = null, ...cArgs)
		{
			super();
			this.cArgs = cArgs;
			this.className = className;
		}
		
		/** Constructor args. Maximum 10. */
		public function get cArgs():Array { return _cArgs; }
		
		/** @private */
		public function set cArgs(value:Array):void
		{
			_cArgs = value;
			_creationFunc = this["createWithArg" + cArgs.length];
		}
		
		/** Create new instance of class. 
		 * @return Instance of the class. */		
		public function newInstance():*
		{
			var instance:Object = _creationFunc();
			if(_properties)
			{
				for each (var prop:PropertyProxy in _properties) 
				{
					var property:* = prop.value;
					if(property is ClassFactory)
						property = (property as ClassFactory).newInstance();
					
					instance[prop.name.localName] = property; 
				}
			}
			
			if(_functions)
			{
				for each (var func:FunctionProxy in _functions) 
				{
					instance[func.name.localName].apply(null, func.parameters); 
				}
			}
			
			return instance;
		}
		
		/** @inheritDoc */
		override flash_proxy function setProperty(name:*, value:*):void
		{
			if(!_properties)
				_properties = new Vector.<PropertyProxy>();
			_properties.push(new PropertyProxy(name, value));
		}
		
		/** @inheritDoc */
		override flash_proxy function callProperty(name:*, ...parameters):*
		{
			if(!_functions)
				_functions = new Vector.<FunctionProxy>();
			
			_functions.push(new FunctionProxy(name, parameters));
		}
		
		/** @private */
		private function createWithArg0():Object
		{
			return new className();
		}
		
		/** @private */
		private function createWithArg1():Object
		{
			return new className(cArgs[0]);
		}
		
		/** @private */
		private function createWithArg2():Object
		{
			return new className(cArgs[0], cArgs[1]);
		}
		
		/** @private */
		private function createWithArg3():Object
		{
			return new className(cArgs[0], cArgs[1], cArgs[2]);
		}
		
		/** @private */
		private function createWithArg4():Object
		{
			return new className(cArgs[0], cArgs[1], cArgs[2], cArgs[3]);
		}
		
		/** @private */
		private function createWithArg5():Object
		{
			return new className(cArgs[0], cArgs[1], cArgs[2], cArgs[3], cArgs[4]);
		}
		
		/** @private */
		private function createWithArg6():Object
		{
			return new className(cArgs[0], cArgs[1], cArgs[2], cArgs[3], cArgs[4], cArgs[5]);
		}
		
		/** @private */
		private function createWithArg7():Object
		{
			return new className(cArgs[0], cArgs[1], cArgs[2], cArgs[3], cArgs[4], cArgs[5], cArgs[6]);
		}
		
		/** @private */
		private function createWithArg8():Object
		{
			return new className(cArgs[0], cArgs[1], cArgs[2], cArgs[3], cArgs[4], cArgs[5], cArgs[6], cArgs[7]);
		}
		
		/** @private */
		private function createWithArg9():Object
		{
			return new new className(cArgs[0], cArgs[1], cArgs[2], cArgs[3], cArgs[4], cArgs[5], cArgs[6], cArgs[7], cArgs[8]);
		}
		
		/** @private */
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
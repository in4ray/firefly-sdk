// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.utils
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
		 */		
		public function ClassFactory(classItem:Class = null)
		{
			super();
			this.classItem = classItem;
		}
		
		/**
		 *  Class to be instantiated. 
		 */		
		public var classItem:Class;
		
		/**
		 * Create new instance of class. 
		 * @return Instance.
		 */		
		public function newInstance():*
		{
			var instance:*;
			if(cArgs)
			{
				switch(cArgs.length)
				{
					case 1:
					{
						instance = new classItem(cArgs[0]);
						break;
					}
					case 2:
					{
						instance = new classItem(cArgs[0], cArgs[1]);
						break;
					}
					case 3:
					{
						instance = new classItem(cArgs[0], cArgs[1], cArgs[2]);
						break;
					}
					case 4:
					{
						instance = new classItem(cArgs[0], cArgs[1], cArgs[2], cArgs[3]);
						break;
					}
					case 5:
					{
						instance = new classItem(cArgs[0], cArgs[1], cArgs[2], cArgs[3], cArgs[4]);
						break;
					}
					case 6:
					{
						instance = new classItem(cArgs[0], cArgs[1], cArgs[2], cArgs[3], cArgs[4], cArgs[5]);
						break;
					}
					case 7:
					{
						instance = new classItem(cArgs[0], cArgs[1], cArgs[2], cArgs[3], cArgs[4], cArgs[5], cArgs[6]);
						break;
					}
					case 8:
					{
						instance = new classItem(cArgs[0], cArgs[1], cArgs[2], cArgs[3], cArgs[4], cArgs[5], cArgs[6], cArgs[7]);
						break;
					}
					case 9:
					{
						instance = new classItem(cArgs[0], cArgs[1], cArgs[2], cArgs[3], cArgs[4], cArgs[5], cArgs[6], cArgs[7], cArgs[8]);
						break;
					}
					case 10:
					{
						instance = new classItem(cArgs[0], cArgs[1], cArgs[2], cArgs[3], cArgs[4], cArgs[5], cArgs[6], cArgs[7], cArgs[8], cArgs[9]);
						break;
					}
				}
			}
			else
			{
				instance = new classItem();
			}
				
			for each (var prop:PropertyProxy in properties) 
			{
				var property:* = prop.value;
				if(property is ClassFactory)
					property = (property as ClassFactory).newInstance();
				
				instance[prop.name.localName] = property; 
			}
			
			for each (var func:FunctionProxy in functions) 
			{
				instance[func.name.localName].apply(null, func.parameters); 
			}
			
			
			return instance;
		}
		
		/**
		 * Constructor args. Max 10.
		 */		
		public var cArgs:Array;
		
		private var properties:Vector.<PropertyProxy> = new Vector.<PropertyProxy>();
		private var functions:Vector.<FunctionProxy> = new Vector.<FunctionProxy>();
		
		override flash_proxy function setProperty(name:*, value:*):void
		{
			properties.push(new PropertyProxy(name, value));
		}
		
		override flash_proxy function callProperty(name:*, ...parameters):*
		{
			functions.push(new FunctionProxy(name, parameters));
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
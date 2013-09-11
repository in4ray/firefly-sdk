// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.cache
{
	import com.firefly.core.utils.ClassFactory;
	
	/** Class which helps to cashe objects by class name. */	
	public class Cache
	{
		private static const _factory:ClassFactory = new ClassFactory();		
		private var _className:Class;
		private var _items:Array;
		
		/** Maximum cashed objects. 
		 *  @default int.MAX_VALUE */	
		public var limit:int = int.MAX_VALUE;
		
		/** Constructor. 
		 *  @param className Class name of objects to be cashed. */	
		public function Cache(className:Class)
		{
			_className = className;
			_items = new Array();
		}
		
		/** Return cashed object or create the new instance in case aren't any cashed objects.
		 *  @param args Arguments for object creation.
		 *  @return Cashed object. */		
		public function getItem(...args):*
		{
			if(_items.length > 0)
				return _items.pop();
			
			_factory.className = _className;
			_factory.cArgs = args;
			return _factory.newInstance();
		}
		
		/** Cashe an object.
		 *  @param item Object need to cash. */		
		public function cache(item:*):void
		{
			if(_items.length < limit)
				_items.push(item);
		}
	}
}
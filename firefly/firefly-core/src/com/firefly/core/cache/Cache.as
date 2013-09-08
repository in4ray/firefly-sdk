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

	public class Cache
	{
		private static const factory:ClassFactory = new ClassFactory();
		
		public function Cache(className:Class)
		{
			this.className = className;
			items = new Array();
		}
		
		public var items:Array;
		
		public var limit:int = int.MAX_VALUE;
		
		private var className:Class;
		
		public function getItem(...args):Object
		{
			if(items.length > 0)
				return items.pop();
			
			factory.className = className;
			factory.cArgs = args;
			return factory.newInstance();
		}
		
		public function cache(item:*):void
		{
			if(items.length < limit)
				items.push(item);
		}
	}
}
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
	import com.in4ray.gaming.utils.ClassFactory;
	
	import flash.utils.Dictionary;

	/**
	 * Game factory. Register/cache game items by type.
	 * Already cached game item could be reused on game screen. 
	 */	
	public class Factory
	{
		/**
		 * Constractor. 
		 */		
		public function Factory()
		{
		}
		
		/**
		 * Register game items.
		 *  
		 * @param type Game item type.
		 * @param factory Game item class factory.
		 */		
		public function registerType(type:String, factory:ClassFactory):void
		{
			itemTypes[type] = new FactoryItem(type, factory);
		}
		
		private var itemTypes:Dictionary = new Dictionary();
		
		/**
		 * Get cached game item by type. 
		 * 
		 * @param type Game item type.
		 * 
		 * @return Instance of game item.
		 */		
		public function getItem(type:String):*
		{
			if(itemTypes.hasOwnProperty(type))
				return (itemTypes[type] as FactoryItem).getItem();
			
			return null;
		}
		
		/**
		 * Cache game item by type for further reusage.
		 *  
		 * @param type Game item type.
		 * @param item Instance of game item.
		 */		
		public function cacheItem(type:String, item:*):void
		{
			(itemTypes[type] as FactoryItem).cacheItem(item);
		}
		
		/**
		 * Compute elements in cache.
		 *  
		 * @param type Game item type.
		 * @return Count items in cache, -1 if type is not registered
		 */		
		public function itemsCount(type:String):int
		{
			if(itemTypes.hasOwnProperty(type))
				return (itemTypes[type] as FactoryItem).length();
			else
				return -1;		
		}
	}
}


import com.in4ray.gaming.utils.ClassFactory;

/**
 * Internal class which describes single insatnce of game item. 
 */
class FactoryItem
{
	private var type:String;

	private var factory:ClassFactory;
	
	private var cache:Vector.<*> 
	
	/**
	 * Constractor.
	 *  
	 * @param type Game item type.
	 * @param factory Game item class factory.
	 */		
	public function FactoryItem(type:String, factory:ClassFactory)
	{
		this.factory = factory;
		this.type = type;
		cache = new Vector.<*>();
	}
	
	/**
	 * Cache game item. 
	 * 
	 * @param item Insatnce of game item.
	 */	
	public function cacheItem(item:*):void
	{
		cache.push(item);
	}
	
	/**
	 * Return cached game item instance or create new instance by class factory. 
	 * 
	 * @return Game item.
	 */	
	public function getItem():*
	{
		if(cache.length > 0)
			return cache.pop();
		
		return factory.newInstance();
	}
	
	/**
	 * Return count of items 
	 * 
	 * @return count of items.
	 */	
	public function length():int
	{
		return cache.length;
	}
}
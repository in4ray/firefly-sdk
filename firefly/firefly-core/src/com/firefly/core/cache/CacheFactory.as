package com.firefly.core.cache
{
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import avmplus.getQualifiedClassName;

	/** Class which helps to cashe different objects by class names. */
	public class CacheFactory
	{
		private var _cache:Dictionary = new Dictionary();
		
		public function CacheFactory()
		{
		}
		
		/** Return cashed object or create the new instance in case aren't any cashed objects.
		 *  @param args Arguments for object creation.
		 *  @return Cashed object. */		
		public function getItem(clas:Class, ...args):*
		{
			var name:String = getQualifiedClassName(clas);
			if(!_cache.hasOwnProperty(name))
				_cache[name] = new Cache(clas);
			
			return _cache[name].getItem.apply(null, args);
		}
		
		/** Cashe an object.
		 *  @param item Object need to cash. */		
		public function cache(item:*):void
		{
			var name:String = getQualifiedClassName(item);
			if(!_cache.hasOwnProperty(name))
				_cache[name] = new Cache(getDefinitionByName(name) as Class);
			
			_cache[name].cache(item);
		}
	}
}
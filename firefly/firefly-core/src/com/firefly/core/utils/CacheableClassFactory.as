package com.firefly.core.utils
{
	[ExcludeClass]
	public class CacheableClassFactory extends ClassFactory
	{
		private var _cacheInstance:*;
		
		public function CacheableClassFactory(className:Class=null, ...cArgs)
		{
			super(className);
			
			this.cArgs = cArgs;
		}
		
		override public function newInstance():*
		{
			if(!_cacheInstance)
				_cacheInstance = super.newInstance();
			
			return _cacheInstance;
		}
	}
}
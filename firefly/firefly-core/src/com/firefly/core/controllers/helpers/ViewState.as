package com.firefly.core.controllers.helpers
{
	import com.firefly.core.display.IView;
	import com.firefly.core.utils.ClassFactory;

	public class ViewState
	{
		public var name:String;
		public var factory:ClassFactory;
		public var assetState:String;
		public var cache:Boolean;
		public var instance:IView;
		
		public function ViewState(name:String, factory:ClassFactory, assetState:String="", cache:Boolean = true)
		{
			this.cache = cache;
			this.assetState = assetState;
			this.factory = factory;
			this.name = name;
		}
		
		public function getInstance():IView
		{
			if(!instance)
				instance = factory.newInstance();
			
			return instance;
		}
	}
}
// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.controllers.helpers
{
	import com.firefly.core.display.IView;
	import com.firefly.core.utils.ClassFactory;

	/** The ViewState class describes view state which uses in views stack, navigator, 
	 *  screen navigator controllers. It contains infrormation about view class, instance 
	 *  of view class, view state name, asset state name. */	
	public class ViewState
	{
		/** @private */		
		private var _instance:IView;
		
		/** View state name. */		
		public var name:String;
		
		/** Factory class for creation view component. */
		public var factory:ClassFactory;
		
		/** Asset state name. */
		public var assetState:String;
		
		/** Defines caching of view component instance. */
		public var cache:Boolean;
		
		/** Constructor.
		 *  @param name View state name.
		 *  @param factory Factory class for creation view component.
		 *  @param assetState Asset state name.
		 *  @param cache Defines caching of view component instance. */		
		public function ViewState(name:String, factory:ClassFactory, assetState:String="", cache:Boolean=true)
		{
			this.assetState = assetState;
			this.factory = factory;
			this.name = name;
			this.cache = cache;
		}
		
		/** Instance of created view component. */		
		public function get instance():IView
		{
			if(!_instance || !cache)
				_instance = factory.newInstance();
			return _instance;
		}
	}
}
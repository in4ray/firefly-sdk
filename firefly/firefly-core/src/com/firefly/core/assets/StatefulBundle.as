// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.assets
{
	import com.firefly.core.async.Future;
	import com.firefly.core.utils.Log;
	import com.firefly.core.utils.SingletonLocator;
	
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import avmplus.getQualifiedClassName;
	
	/** Stateful bundle class for loading, creating and storing different assets in the same 
	 *  game state base on specific asset state.
	 * 
	 *  @see com.firefly.core.assets.StatefulTextureBundle
	 *  @see com.firefly.core.assets.StatefulAudioBundle */	
	public class StatefulBundle implements IAssetBundle
	{
		/** @private */		
		private var _currentState:String;
		
		/** @private */
		protected var _name:String;
		/** @private */
		protected var _singleton:StatefulBundle;
		/** @private */
		protected var _bundles:Dictionary;
		
		/** Constructor. */		
		public function StatefulBundle()
		{
			_name = getQualifiedClassName(this);
			_singleton = SingletonLocator.getInstance(getDefinitionByName(_name) as Class, this);
			
			if(_singleton == this)
			{
				_bundles = new Dictionary();
				regBundles();
			}
		}
		
		/** Unique name of bundle. */
		public function get name():String { return _name; }
		/** Current state. */
		public function get currentState():String { return _currentState; }
		
		/** Register bundles. This method calls after creation of the composite bundle. */
		protected function regBundles():void { }
		
		/** Register one state.
		 *  @param state Asset state.
		 *  @param bundle Asset bundle which will be used in this state. */		
		protected function regState(state:String, bundle:IAssetBundle):void
		{
			if(_singleton != this)
				return _singleton.regState(state, bundle);
			
			if(!(state in _bundles))
				_bundles[state] = bundle;
		}
		
		/** Switch stateful bundle to another asset state.
		 * 	@param state Asset state to which need to switch. */		
		public function switchToState(state:String):void
		{
			if(_singleton != this)
				return _singleton.switchToState(state);
			
			if(!(state in _bundles))
			{
				CONFIG::debug {
					Log.error("State {0} isn't registered.", state);
				};
			}
			
			_currentState = state;
		}
		
		/** @inheritDoc */		
		public function load():Future
		{
			return _bundles[_currentState].load();
		}
		
		/** @inheritDoc */	
		public function unload():void
		{
			_bundles[_currentState].unload();
		}
		
		/** @inheritDoc */	
		public function isDirty():Boolean
		{
			return _bundles[_currentState].isDirty();
		}
	}
}
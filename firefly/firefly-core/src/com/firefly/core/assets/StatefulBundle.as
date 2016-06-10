package com.firefly.core.assets
{
	import com.firefly.core.async.Future;
	import com.firefly.core.utils.Log;
	import com.firefly.core.utils.SingletonLocator;
	
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import avmplus.getQualifiedClassName;
	
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
		
		protected function regState(state:String, bundle:IAssetBundle):void
		{
			if(_singleton != this)
				return _singleton.regState(state, bundle);
			
			if(!(state in _bundles))
				_bundles[state] = bundle;
		}
		
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
		
		public function load():Future
		{
			return _bundles[_currentState].load();
		}
		
		public function unload():void
		{
			_bundles[_currentState].unload();
		}
		
		public function isDirty():Boolean
		{
			return _bundles[_currentState].isDirty();
		}
	}
}
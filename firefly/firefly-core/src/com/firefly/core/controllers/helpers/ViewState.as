package com.firefly.core.controllers.helpers
{
	import com.firefly.core.utils.ClassFactory;

	public class ViewState
	{
		private var _state:String;
		private var _factory:ClassFactory;
		private var _assetState:String;
		
		public function ViewState(state:String, factory:ClassFactory, assetState:String="")
		{
			_assetState = assetState;
			_factory = factory;
			_state = state;
		}

		public function get state():String { return _state; }
		public function get factory():ClassFactory { return _factory; }
		public function get assetState():String { return _assetState; }


	}
}
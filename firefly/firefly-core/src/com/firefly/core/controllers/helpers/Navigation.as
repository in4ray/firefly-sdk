package com.firefly.core.controllers.helpers
{
	import com.firefly.core.controllers.ViewNavigatorController;
	
	public class Navigation
	{
		private var _navigator:ViewNavigatorController;
		private var _trigger:String;
		private var _fromState:String;
		private var _toState:String;
		
		public function Navigation(navigator:ViewNavigatorController, trigger:String, fromState:String, toState:String)
		{
			_navigator = navigator;
			_trigger = trigger;
			_fromState = fromState;
			_toState = toState;
		}

		public function get trigger():String { return _trigger; }
		public function get fromState():String { return _fromState; }
		public function get toState():String { return _toState; }

	}
}
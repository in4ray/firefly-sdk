package com.firefly.core.controllers.helpers
{
	import com.firefly.core.controllers.ViewNavigatorCtrl;
	import com.firefly.core.transitions.ITransition;
	
	public class Navigation
	{
		public var navigator:ViewNavigatorCtrl;
		public var trigger:String;
		public var fromState:String;
		public var toState:String;
		public var transition:ITransition;
		
		public function Navigation(navigator:ViewNavigatorCtrl, trigger:String, fromState:String, toState:String, transition:ITransition)
		{
			this.transition = transition;
			this.navigator = navigator;
			this.trigger = trigger;
			this.fromState = fromState;
			this.toState = toState;
		}
	}
}
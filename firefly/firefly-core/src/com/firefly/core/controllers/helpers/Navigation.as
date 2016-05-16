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
	import com.firefly.core.transitions.ITransition;
	
	/** The Navigation class describes navigation between view/game states. */
	public class Navigation
	{
		/** Event trigger defines when this navigation should start. */		
		public var trigger:String;
		/** From which state should be navigation. */		
		public var fromState:String;
		/** To which state should be navigation. */
		public var toState:String;
		/** Specific transition which will be used during navigation. */
		public var transition:ITransition;
		
		/** Constructor.
		 *  @param trigger Event trigger defines when this navigation should start.
		 *  @param fromState From which state should be navigation.
		 *  @param toState To which state should be navigation.
		 *  @param transition Specific transition which will be used during navigation. */		
		public function Navigation(trigger:String, fromState:String, toState:String, transition:ITransition)
		{
			this.transition = transition;
			this.trigger = trigger;
			this.fromState = fromState;
			this.toState = toState;
		}
	}
}
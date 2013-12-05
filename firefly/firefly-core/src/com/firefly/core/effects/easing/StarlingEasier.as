// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.effects.easing
{
	import starling.animation.Transitions;

	public class StarlingEasier implements IEaser
	{
		private var _transitionFunc:Function;		
		private var _transition:String;
		
		public function StarlingEasier(transition:String)
		{
			this.transition = transition;
		}
		
		public function get transition():String { return _transition; }
		public function set transition(value:String):void
		{
			if (_transition != value)
			{
				_transition = value;
				_transitionFunc = Transitions.getTransition(_transition);
			}
		}
		
		public function ease(ratio:Number):Number
		{
			return _transitionFunc(ratio);
		}
	}
}
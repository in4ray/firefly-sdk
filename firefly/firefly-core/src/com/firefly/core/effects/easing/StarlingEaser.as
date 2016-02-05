// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.effects.easing
{
	import starling.animation.Transitions;

	/** The StarlingEaser class defines Starling ease functions for using in animations. */
	public class StarlingEaser implements IEaser
	{
		/** @private */
		private var _transitionFunc:Function;
		/** @private */
		private var _transition:String;
		
		/** Constructor.
		 *  @param transition Straling transition type. */
		public function StarlingEaser(transition:String="linear")
		{
			this.transition = transition;
		}
		
		/** Straling transition type.
		 *  @default "linear" */
		public function get transition():String { return _transition; }
		public function set transition(value:String):void
		{
			_transition = value;
			_transitionFunc = Transitions.getTransition(_transition);
		}
		
		/** @inheritDoc */
		public function ease(ratio:Number):Number
		{
			return _transitionFunc(ratio);
		}
	}
}
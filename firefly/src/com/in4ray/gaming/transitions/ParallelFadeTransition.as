// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.transitions
{
	import com.in4ray.gaming.effects.Fade;
	
	/**
	 * Transition that fades out previous state and fades in next state in parallel. 
	 */	
	public class ParallelFadeTransition extends ParallelTransition
	{
		/**
		 * Constructor.
		 *  
		 * @param trigger Event trigger
		 * @param fromState Transition from state
		 * @param toState Transition to state
		 */		
		public function ParallelFadeTransition(trigger:String, fromState:String="*", toState:String="*")
		{
			super(trigger, fromState, toState, new Fade(null, NaN, 0, 1), new Fade(null, NaN, 1, 0));
		}
		
		/**
		 * @private 
		 */		
		override protected function animationComplete():void
		{
			super.animationComplete();
			
			if(_fromViewState)
				_fromViewState.getView().alpha = 1;
			
			if(_toViewState)
				_toViewState.getView().alpha = 1;
		}
	}
}
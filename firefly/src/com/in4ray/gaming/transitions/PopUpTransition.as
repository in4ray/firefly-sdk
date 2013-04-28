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
	import com.in4ray.gaming.async.callAsync;
	import com.in4ray.gaming.components.Sprite;
	import com.in4ray.gaming.effects.Scale;
	
	import starling.animation.Transitions;
	
	/**
	 * Transition that scales in popup state. 
	 */	
	public class PopUpTransition extends ParallelTransition
	{
		/**
		 * Constructor.
		 *   
		 * @param trigger Event trigger.
		 * @param fromState Tarnsition from state.
		 * @param toState Tarnsition to state.
		 * @param duration Duration of animation.
		 */		
		public function PopUpTransition(trigger:String, fromState:String, toState:String, duration:Number = 300)
		{
			var fromScale:Scale =  new Scale(null, NaN, 0, 1);
			var toScale:Scale =  new Scale(null, NaN, 1, 0.1);
			toScale.transition = Transitions.EASE_IN;
			
			super(trigger, fromState, toState, fromScale, toScale);
			this.duration = duration;
		}
		
		private var toViewAlpha:Number = 1;
		
		/**
		 * @private 
		 */		
		override protected function playParallel():void
		{
			if(_toViewState)
			{
				_toViewState.getView().scaleX = _toViewState.getView().scaleY = 0.1;
				toViewAlpha = _toViewState.getView().alpha;
				_toViewState.getView().alpha = 0.01;
			}
			
			callAsync(startAnimation);
		}
		
		/**
		 * @private 
		 */	
		protected function startAnimation():void
		{
			if(_toViewState)
			{
				var view:Sprite = _toViewState.getView();
				view.setActualPivots(view.width/2, view.height/2); 
				view.setActualPosition(view.x + view.pivotX, view.y + view.pivotY);
				_toViewState.getView().alpha = toViewAlpha;
			}
			super.playParallel();
		}
		
		/**
		 * @private 
		 */	
		override protected function animationComplete():void
		{
			super.animationComplete();
			
			var view:Sprite = _toViewState.getView();
			view.setActualPosition(view.x - view.pivotX, view.y - view.pivotY);
			view.setActualPivots(0, 0); 
			
			if(_fromViewState)
				_fromViewState.getView().scaleX = _fromViewState.getView().scaleY = 1;
			
			if(_toViewState)
				_toViewState.getView().scaleX = _toViewState.getView().scaleY = 1;
		}
	}
}
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
	import com.in4ray.gaming.effects.IAnimation;
	import com.in4ray.gaming.effects.Sequence;
	import com.in4ray.gaming.navigation.ViewState;

	/**
	 * Transition that plays animations for from and to texture states one by one. 
	 */	
	public class SequenceTransition extends BasicTransition
	{
		/**
		 * Constructor.
		 *  
		 * @param trigger Even trigger
		 * @param fromState Transition from state.
		 * @param toState Transition to state.
		 * @param fromAnimation Animation for FROM state view.
		 * @param toAnimation Animation for TO state view.
		 */		
		public function SequenceTransition(trigger:String, fromState:String, toState:String, fromAnimation:IAnimation, toAnimation:IAnimation)
		{
			super(trigger, fromState, toState);
			
			this.toAnimation = toAnimation;
			this.fromAnimation = fromAnimation;
		}
		
		private var fromAnimation:IAnimation;

		private var toAnimation:IAnimation;
		
		private var sequence:Sequence;
		
		/**
		 * Duration for animations in milliseconds. 
		 */		
		public var duration:Number;
		
		private var _isPlaying:Boolean;
		
		/**
		 * @inheritDoc 
		 */		
		override public function get isPlaying():Boolean
		{
			return _isPlaying;
		}
		
		/**
		 * @inheritDoc 
		 */	
		override public function play(fromViewState:ViewState, toViewState:ViewState, callBack:Function=null, ...params):void
		{
			_fromViewState = fromViewState;
			_toViewState = toViewState;
			
			this.callBack = callBack;
			this.params = params;
			
			_isPlaying = true;
			
			dispatchRemoving();
			if(_toViewState)
				_navigator.assetManager.switchToState(_toViewState.assetState);
			_navigator.showViewState(_toViewState);
			
			dispatchAdding();
			
			var animations:Array = [];
			if(fromAnimation && fromViewState)
			{
				fromAnimation.target = fromViewState.getView();
				animations.push(fromAnimation);
			}
			if(toAnimation && toViewState)
			{
				toAnimation.target = toViewState.getView();
				animations.push(toAnimation);
			}
			
			if(animations.length > 0)
			{
				sequence = new Sequence(null, duration, animations);
				sequence.completeCallback = animationComplete;
				sequence.disposeOnComplete = true;
				sequence.play();
			}
			else
			{
				animationComplete();
			}
		}
		
		/**
		 * @inheritDoc 
		 */	
		override public function end():void
		{
			if(sequence)
			{
				sequence.end();
			}
		}
		
		/**
		 * @private 
		 */	
		protected function animationComplete():void
		{
			_isPlaying = false;
			
			_navigator.hideViewState(_fromViewState);
			_navigator.showViewState(_toViewState);
			dispatchRemoved();
			dispatchAdded();
			
			invokeCallback();
		}
	}
}
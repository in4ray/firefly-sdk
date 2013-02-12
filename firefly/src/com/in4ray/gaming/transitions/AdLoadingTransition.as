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
	import com.in4ray.gaming.events.ViewEvent;
	import com.in4ray.gaming.navigation.ViewState;
	
	/**
	 * Loading texture with advertisement that will be shown while loading. 
	 */	
	public class AdLoadingTransition extends LoadingTransition
	{

		private var adStates:Array;

		private var randomness:Number;

		private var originalLoadingViewState:ViewState;
		
		/**
		 * Constructor.
		 *  
		 * @param trigger Trigger event.
		 * @param fromState Transition from state.
		 * @param toState Transition to state.
		 * @param loadingViewState View state that will be shown while transition.
		 * @param adStates List of advertisment view states that will be show randomly while loading.
		 * @param randomness Show advertisment chance (show ad if Math.random() &lt; randomness)
		 */		
		public function AdLoadingTransition(trigger:String, fromState:String, toState:String, loadingViewState:ViewState, adStates:Array, randomness:Number = 0.4)
		{
			super(trigger, fromState, toState, loadingViewState);
			originalLoadingViewState = loadingViewState;
			this.randomness = randomness;
			this.adStates = adStates;
		}
		
		/**
		 * @inheritDoc 
		 */		
		override public function play(fromViewState:ViewState, toViewState:ViewState, callBack:Function=null, ...params):void
		{
			loadingViewState = originalLoadingViewState;
			if(adStates.length > 0 && Math.random() < randomness)
			{
				loadingViewState = getAdState();
				loadingViewState.getView().addEventListener(ViewEvent.CLOSE, adCloseHandler);
			}
			
			super.play.apply(null, [fromViewState, toViewState, callBack].concat(params));
		}
		
		/**
		 * @private 
		 */		
		protected function getAdState():ViewState
		{
			if(adStates.length == 1)
				return adStates[0];
			
			return adStates[Math.round(Math.random()*(adStates.length-1))];
		}
		
		/**
		 * @private 
		 */		
		protected function adCloseHandler(event:ViewEvent):void
		{
			loadingViewState.getView().removeEventListener(ViewEvent.CLOSE, adCloseHandler);
			if(textureLoadedFlag)
			{
				super.textureLoaded();
			}
			else
			{
				loadingViewState = originalLoadingViewState;
				_navigator.showViewState(loadingViewState);
				loadingViewState.getView().dispatchEvent(new ViewEvent(ViewEvent.ADDING_TO_NAVIGATOR));
				loadingViewState.getView().dispatchEvent(new ViewEvent(ViewEvent.ADDED_TO_NAVIGATOR));
			}
		}
		
		private var textureLoadedFlag:Boolean;

		/**
		 * @inheritDoc 
		 */	
		override protected function textureLoaded():void
		{
			textureLoadedFlag = true;
			
			if(loadingViewState == originalLoadingViewState)
			{
				super.textureLoaded();
			}
		}
	}
}
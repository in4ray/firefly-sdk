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
	import com.in4ray.gaming.navigation.ViewNavigator;
	import com.in4ray.gaming.navigation.ViewState;

	/**
	 * Interface for view navigation transitions. 
	 */	
	public interface ITransition
	{
		/**
		 * Transition from state.  
		 */		
		function get fromState():String;
		function set fromState(value:String):void;
		
		/**
		 * Transition to state.  
		 */	
		function get toState():String;
		function set toState(value:String):void;
		
		/**
		 * Transition trigger event. 
		 */		
		function get trigger():String;
		function set trigger(value:String):void;
		
		/**
		 * View state navigator. 
		 */		
		function set navigator(value:ViewNavigator):void;
		
		/**
		 * Is transition playing. 
		 */		
		function get isPlaying():Boolean;
		
		/**
		 * Play transition.
		 *  
		 * @param fromViewState Transition from state.  
		 * @param toViewState Transition to state.  
		 * @param callBack Function that will be called on complete of playing.
		 * @param params Parameters for callback function.
		 */		
		function play(fromViewState:ViewState, toViewState:ViewState, callBack:Function=null, ...params):void;
		
		/**
		 * Move transition to the end state. 
		 */		
		function end():void;
	}
}
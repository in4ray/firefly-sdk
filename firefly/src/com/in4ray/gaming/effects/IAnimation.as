// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.effects
{
	/**
	 * Interface for all animations. 
	 */	
	public interface IAnimation
	{
		/**
		 * Play effect. 
		 */		
		function play():void;
		
		/**
		 * Pause effect, can be resumed. 
		 */		
		function pause():void;
		
		/**
		 * Resume paused effect. 
		 */		
		function resume():void;
		
		/**
		 * Stop effect, can't be resumed. 
		 */		
		function stop():void;
		
		/**
		 * Jump effect to the end position. 
		 */		
		function end():void;
		
		/**
		 * Dispose anomation. 
		 */		
		function dispose():void;
	
		/**
		 * Target of animation. 
		 */
		function get target():Object;
		function set target(value:Object):void;
		
		/**
		 * Animation duration in milliseconds.
		 */
		function get duration():Number;
		function set duration(value:Number):void;
		
		/**
		 * Delay before starting animation in milliseconds. 
		 */		
		function get delay():Number;
		function set delay(value:Number):void;
		
		/**
		 * Is animation currently playing. 
		 */		
		function get isPlaying():Boolean;
		
		/**
		 * Loop animation. 
		 */		
		function get loop():Boolean;
		function set loop(value:Boolean):void;
		
		
		/**
		 * Function that will be called after animation completes. 
		 */		
		function get completeCallback():Function;
		function set completeCallback(value:Function):void;
		
		/**
		 * Parameters for complete callback. 
		 */		
		function get completeArgs():Array;
		function set completeArgs(value:Array):void;
		
		/**
		 * Easing function for animation.
		 * @see starling.animation.Transitions
		 */		
		function get transition():String;
		function set transition(value:String):void;
		
		/**
		 * Call dispose function on animation complete. 
		 */		
		function get disposeOnComplete():Boolean;
		function set disposeOnComplete(value:Boolean):void;
	}
}
// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.effects
{
	import com.firefly.core.async.Future;
	import com.firefly.core.effects.easing.IEaser;
	
	import starling.animation.Juggler;
	import starling.display.DisplayObject;

	/** The interface for all animations. */
	public interface IAnimation
	{
		/** The target of animation. */
		function get target():DisplayObject;
		function set target(value:DisplayObject):void;
		
		/** The animation duration in milliseconds. */
		function get duration():Number;
		function set duration(value:Number):void;
		
		/** The delay before starting animation in seconds. */                
		function get delay():Number;
		function set delay(value:Number):void;
		
		/** Loop the animation. */                
		function get loop():Boolean;
		function set loop(value:Boolean):void;
		
		/** The number of times the animation will be executed. */
		function get repeatCount():int;
		function set repeatCount(value:int):void;
		
		/** The delay between repeat of the animation in seconds. */
		function get repeatDelay():Number;
		function set repeatDelay(value:Number):void;
		
		/** Call dispose function on animation complete. */                
		function get disposeOnComplete():Boolean;
		function set disposeOnComplete(value:Boolean):void;
		
		/** The juggler instance. */                
		function get juggler():Juggler;
		function set juggler(value:Juggler):void;
		
		/** The easer modification of animation. */
		function get easer():IEaser;
		function set easer(value:IEaser):void;
		
		/** Is the animation currently playing. */                
		function get isPlaying():Boolean;
		/** Is the animation currently paused. */                
		function get isPause():Boolean;
		/** Is the default Starling Juggler class. */
		function get isDefaultJuggler():Boolean;
		
		/** Play the animation. */                
		function play():Future;
		
		/** Pause the animation, can be resumed. */                
		function pause():void;
		
		/** Resume the paused animation. */                
		function resume():void;
		
		/** Stop the animation, can't be resumed. */                
		function stop():void;
		
		/** Jump the animation to the end position. */                
		function end():void;
		
		/** Dispose the animation. */                
		function dispose():void;
		
	}
}
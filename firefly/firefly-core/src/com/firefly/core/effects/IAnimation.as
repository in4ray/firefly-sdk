// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
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

	/** The interface for all animations. */
	public interface IAnimation
	{
		/** The target of the animation. */
		function get target():Object;
		function set target(value:Object):void;
		
		/** The animation duration in seconds. */
		function get duration():Number;
		function set duration(value:Number):void;
		
		/** The delay before starting the animation in seconds. */                
		function get delay():Number;
		function set delay(value:Number):void;
		
		/** The number of times the animation will be executed. */
		function get repeatCount():int;
		function set repeatCount(value:int):void;
		
		/** The delay between repeats of the animation in seconds. */
		function get repeatDelay():Number;
		function set repeatDelay(value:Number):void;
		
		/** The Juggler instance. */                
		function get juggler():Juggler;
		function set juggler(value:Juggler):void;
		
		/** The easer modification of the animation. */
		function get easer():IEaser;
		function set easer(value:IEaser):void;
		
		/** Is the animation currently playing. */                
		function get isPlaying():Boolean;
		/** Is the animation currently paused. */                
		function get isPause():Boolean;
		/** Is the default Starling Juggler class. */
		function get isDefaultJuggler():Boolean;
		
		/** Play the animation.
		 *  @return Future instance to get information about progress of the animation and when 
		 *  it will be completed. */                
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
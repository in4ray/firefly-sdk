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
	
	import starling.animation.Juggler;

	/** Interface for all animations. */
	public interface IAnimation
	{
		/** Target of animation. */
		function get target():Object;
		function set target(value:Object):void;
		
		/** Animation duration in milliseconds. */
		function get duration():Number;
		function set duration(value:Number):void;
		
		/** Delay before starting animation in milliseconds. */                
		function get delay():Number;
		function set delay(value:Number):void;
		
		/** Loop animation. */                
		function get loop():Boolean;
		function set loop(value:Boolean):void;
		
		/** Call dispose function on animation complete. */                
		function get disposeOnComplete():Boolean;
		function set disposeOnComplete(value:Boolean):void;
		
		/** Juggler instance. */                
		function get juggler():Juggler;
		function set juggler(value:Juggler):void;
		
		/** Is animation currently playing. */                
		function get isPlaying():Boolean;
		/** Is animation currently paused. */                
		function get isPause():Boolean;
		/** Define is default Starling Juggler class. */
		function get isDefaultJuggler():Boolean;
		
		/** Play effect. */                
		function play():Future;
		
		/** Pause effect, can be resumed. */                
		function pause():void;
		
		/** Resume paused effect. */                
		function resume():void;
		
		/** Stop effect, can't be resumed. */                
		function stop():void;
		
		/** Jump effect to the end position. */                
		function end():void;
		
		/** Dispose animation. */                
		function dispose():void;
		
	}
}
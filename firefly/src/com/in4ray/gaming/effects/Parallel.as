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
	import starling.animation.Juggler;
	import starling.core.Starling;
	
	/**
	 * Manager that plays several animations simultaneously. 
	 */	
	public class Parallel implements IAnimation
	{
		/**
		 * Constructor.
		 *  
		 * @param target Target of animation, will be used for child animations if they don't have own targets. 
		 * @param duration Duration in milliseconds, will be used for child animations if they don't have own specified durations.
		 * @param animations Array of animations to be played.
		 */		
		public function Parallel(target:Object=null, duration:Number=NaN, animations:Array = null)
		{
			_target = target;
			_duration = duration;
			
			if(animations)
			{
				for each (var animation:IAnimation in animations) 
				{
					add(animation);
				}
			}
		}
		
		private var _target:Object;
		
		/**
		 * Target of animation, will be used for child animations if they don't have own targets. 
		 */		
		public function get target():Object
		{
			return _target;
		}
		
		public function set target(value:Object):void
		{
			_target = value;
		}
		
		private var _duration:Number;
		
		/**
		 * Duration in milliseconds, will be used for child animations if they don't have own specified durations. 
		 */		
		public function get duration():Number
		{
			return _duration;
		}
		
		public function set duration(value:Number):void
		{
			_duration = value;
		}
		
		private var _delay:Number=NaN;
		
		/**
		 * @inheritDoc
		 */		
		public function get delay():Number
		{
			return _delay;
		}
		
		public function set delay(value:Number):void
		{
			_delay = value;
		}
		
		private var _loop:Boolean = false;
		
		/**
		 * @inheritDoc
		 */
		public function get loop():Boolean
		{
			return _loop;
		}
		
		public function set loop(value:Boolean):void
		{
			_loop = value;
		}
		
		private var _juggler:Juggler;
		
		/**
		 * @inheritDoc
		 */
		public function get juggler():Juggler
		{
			return _juggler ? _juggler : Starling.juggler;
		}
		
		public function set juggler(value:Juggler):void
		{
			_juggler = value;
		}
		
		/**
		 * @inheritDoc 
		 */		
		public function isDefaultJuggler():Boolean
		{
			return _juggler == null;
		}
		
		private var _animations:Vector.<IAnimation> = new Vector.<IAnimation>()

		/**
		 * List of animations to be played.
		 */			
		public function get animations():Vector.<IAnimation>
		{
			return _animations.slice();
		}

		/**
		 * Add animation. 
		 * 
		 * @param animation Animation to be played.
		 */		
		public function add(animation:IAnimation):void
		{
			_animations.push(animation);
		}
		
		/**
		 * Remove animation. 
		 * 
		 * @param animation Animation to be removed.
		 */		
		public function remove(animation:IAnimation):void
		{
			_animations.splice(_animations.indexOf(animation), 1);
		}
		
		/**
		 * @inheritDoc
		 */		
		public function play():void
		{
			completeCount = 0;
			
			for each (var animation:IAnimation in animations) 
			{
				if(!animation.target)
					animation.target = target;
				
				if(!animation.transition)
					animation.transition = transition;
				
				if(isNaN(animation.duration))
					animation.duration = duration;
				
				if(isNaN(animation.delay))
					animation.delay = delay;
				
				if(animation.isDefaultJuggler())
					animation.juggler = juggler;
				
				animation.loop = loop;
				animation.completeCallback = animationComplete;
				animation.play();
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function end():void
		{
			for each (var animation:IAnimation in animations) 
			{
				animation.end();
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function pause():void
		{
			for each (var animation:IAnimation in animations) 
			{
				animation.pause();
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function resume():void
		{
			for each (var animation:IAnimation in animations) 
			{
				animation.resume();
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function stop():void
		{
			for each (var animation:IAnimation in animations) 
			{
				animation.stop();
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function get isPlaying():Boolean
		{
			for each (var animation:IAnimation in animations) 
			{
				if(animation.isPlaying)
					return true;
			}
			
			return false;
		}
		
		private var completeCount:uint = 0;
		private function animationComplete():void
		{
			completeCount++;
			
			if(completeCount == animations.length)
			{
				if(completeCallback != null)
					completeCallback.apply(null, completeArgs);
				
				if(_disposeOnComplete)
					dispose();
			}
		}
		
		private var _completeCallback:Function;
		
		/**
		 * @inheritDoc
		 */
		public function get completeCallback():Function
		{
			return _completeCallback;
		}
		
		public function set completeCallback(value:Function):void
		{
			_completeCallback = value;
		}
		
		private var _completeArgs:Array;
		
		/**
		 * @inheritDoc
		 */
		public function get completeArgs():Array
		{
			return _completeArgs;
		}
		
		public function set completeArgs(value:Array):void
		{
			_completeArgs = value;
		}
		
		private var _transition:String;
		
		/**
		 * @inheritDoc
		 */
		public function get transition():String
		{
			return _transition;
		}
		
		public function set transition(value:String):void
		{
			_transition = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public function dispose():void
		{
			stop();
			_completeCallback = null;
			_completeArgs = null;
			target = null;
			
			for each (var animation:IAnimation in animations) 
			{
				animation.dispose();
			}
			animations.length = 0;
		}
		
		private var _disposeOnComplete:Boolean;
		
		/**
		 * @inheritDoc
		 */
		public function get disposeOnComplete():Boolean
		{
			return _disposeOnComplete;
		}
		
		public function set disposeOnComplete(value:Boolean):void
		{
			_disposeOnComplete = value;
		}
	}
}
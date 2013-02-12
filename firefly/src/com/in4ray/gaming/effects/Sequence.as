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
	 * Manager that plays several animations . 
	 */	
	public class Sequence implements IAnimation
	{
		/**
		 * Constructor.
		 *  
		 * @param target Target of animation, will be used for child animations if they don't have own targets.
		 * @param duration Duration in milliseconds, will be used for child animations if they don't have own specified durations.
		 * @param animations Array of animations to be played.
		 */		
		public function Sequence(target:Object=null, duration:Number=NaN, animations:Array = null)
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
		 * @param animation Animation to be added.
		 * 
		 */		
		public function add(animation:IAnimation):void
		{
			_animations.push(animation);
		}
		
		/**
		 * Remove animation.
		 *  
		 * @param animation Animation to be removed.
		 * 
		 */	
		public function remove(animation:IAnimation):void
		{
			_animations.splice(_animations.indexOf(animation), 1);
		}
		
		private var currentIndex:uint;
		
		/**
		 * @inheritDoc 
		 */	
		public function play():void
		{
			currentIndex = 0;
			
			playInternal();
		}
		
		
		private function playInternal():void
		{
			currentIndex++;
			
			if(currentIndex == animations.length && loop)
				currentIndex = 0;
			
			if(currentIndex < animations.length)
			{
				var animation:IAnimation = animations[currentIndex];
				
				if(!animation.target)
					animation.target = target;
				
				if(!animation.transition)
					animation.transition = transition;
				
				if(isNaN(animation.duration))
					animation.duration = duration;
				
				if(isNaN(animation.delay))
					animation.delay = delay;
				
				//animation.loop = loop;
				animation.completeCallback = playInternal;
				
				animation.play();
			}
			else
			{
				if(completeCallback != null)
					completeCallback.apply(null, completeArgs);
				
				if(_disposeOnComplete)
					dispose();
			}
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function end():void
		{
			if(currentIndex < animations.length)
			{
				animations[currentIndex].end();
			}
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function pause():void
		{
			if(currentIndex < animations.length)
			{
				animations[currentIndex].pause();
			}
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function resume():void
		{
			if(currentIndex < animations.length)
			{
				animations[currentIndex].resume();
			}
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function stop():void
		{
			if(currentIndex < animations.length)
			{
				animations[currentIndex].stop();
			}
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function get isPlaying():Boolean
		{
			if(currentIndex < animations.length)
			{
				return animations[currentIndex].isPlaying;
			}
			
			return false;
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
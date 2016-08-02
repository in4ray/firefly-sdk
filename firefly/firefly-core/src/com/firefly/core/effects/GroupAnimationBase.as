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
	import com.firefly.core.Firefly;
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;
	import com.firefly.core.async.helpers.Progress;
	import com.firefly.core.effects.easing.IEaser;
	
	import starling.animation.Juggler;
	
	/** The base class for group animations. This class can't be used for object animation.
	 * 
	 *  @see com.firefly.core.effects.Parallel
	 *  @see com.firefly.core.effects.Sequence */
	public class GroupAnimationBase implements IAnimation
	{
		/** @private */
		private var _juggler:Juggler;
		/** @private */
		private var _target:Object;
		/** @private */
		private var _duration:Number;
		/** @private */
		private var _repeatCount:int;
		/** @private */
		protected var _repeatCountInternal:int;
		/** @private */
		private var _repeatDelay:Number;
		/** @private */
		private var _isPlaying:Boolean;
		/** @private */
		private var _isPause:Boolean;
		/** @private */
		private var _delay:Number;
		/** @private */
		private var _easer:IEaser
		/** @private */
		private var _completer:Completer;
		/** @private */
		private var _progress:Progress;
		/** @private */
		private var _animation:IAnimation;
		/** @private */
		private var _animations:Vector.<IAnimation>;
		/** @private */
		private var _length:int;
		
		/** Constructor.
		 *  @param target Target of animation, will be used for child animations if they don't have own targets. 
		 *  @param duration Duration in seconds, will be used for child animations if they don't have own specified durations.
		 *  @param animations Array of animations to be played. */
		public function GroupAnimationBase(target:Object, duration:Number=NaN, animations:Array=null)
		{
			_target = target;
			_duration = duration;
			_repeatCount = 1;
			_length = _repeatDelay = 0;;
			_completer = new Completer();
			_animations = new Vector.<IAnimation>();
			
			if (animations)
			{
				var length:int = animations.length;
				for (var i:int = 0; i < length; i++) 
				{
					add(animations[i]);
				}
			}
		}
		
		/** Completer uses to send status of progress and complete events. */
		protected function get completer():Completer { return _completer; }
		
		/** Animation helper class. */
		protected function get animation():IAnimation { return _animation; }
		protected function set animation(value:IAnimation):void { _animation = value; }
		
		/** Progress helper class. */
		protected function get progress():Progress { return _progress; }
		protected function set progress(value:Progress):void { _progress = value; }
		
		/** Length of animations. */
		public function get length():int { return _length; }
		
		/** @inheritDoc */
		public function get isDefaultJuggler():Boolean { return _juggler == null; }
		
		/** @inheritDoc */
		public function get isPlaying():Boolean { return _isPlaying; }
		
		/** @inheritDoc */
		public function get isPause():Boolean { return _isPause; }
		
		/** List of animations which will be animated. */
		public function get animations():Vector.<IAnimation> { return _animations; }
		public function set animations(value:Vector.<IAnimation>):void 
		{ 
			_animations = value;
			
			if (_animations)
				_length = _animations.length;
		}
		
		/** @inheritDoc */
		public function get target():Object { return _target; }
		public function set target(value:Object):void { _target = value; }
		
		/** The animation duration in seconds.
		 *  @default NaN */
		public function get duration():Number { return _duration; }
		public function set duration(value:Number):void { _duration = value; }
		
		/** The delay before starting the animation in seconds.
		 *  @default NaN */
		public function get delay():Number { return _delay; }
		public function set delay(value:Number):void { _delay = value; }
		
		/** The number of times the animation will be executed.
		 *  In case if the value is <code>0</code> the animation will be looped.
		 *  @default 1 */
		public function get repeatCount():int { return _repeatCount; }
		public function set repeatCount(value:int):void { _repeatCount = value; }
		
		/** The delay between repeat of the animation in seconds.
		 *  @default 0 */
		public function get repeatDelay():Number { return _repeatDelay; }
		public function set repeatDelay(value:Number):void { _repeatDelay = value; }
		
		/** @inheritDoc */
		public function get juggler():Juggler { return _juggler ? _juggler : Firefly.current.juggler; }
		public function set juggler(value:Juggler):void { _juggler = value; }
		
		/** The easer modification of the animation. This parameter overrides easiers of animations
		 *  in the group in case it isn't <code>null</code>.
		 *  @default Linear */
		public function get easer():IEaser { return _easer; }
		public function set easer(value:IEaser):void { _easer = value; }
		
		/** @inheritDoc */
		public function play():Future
		{
			if(_isPlaying)
				stop();
			
			_progress = new Progress(0, 1)
			_repeatCountInternal = _repeatCount;
			_isPlaying = true;
			
			playNext();
			
			return _completer.future;
		}
		
		protected function playNext():void
		{
			if(_isPlaying && ! _isPause)
			{
				if (isNaN(_delay))
					playInternal();
				else
					Future.delay(_delay).then(playInternal);
			}
		}
		
		/** @private */
		protected function playInternal():void { }
		
		/** @private */
		protected function finish():void
		{
			_isPlaying = false;
		}
		
		/** @inheritDoc */
		public function pause():void 
		{
			_isPlaying = false;
			_isPause = true;
		}
		
		/** @inheritDoc */
		public function resume():void 
		{
			_isPlaying = true;
			_isPause = false;
		}
		
		/** @inheritDoc */
		public function stop():void 
		{
			_isPlaying = _isPause = false;
		}
		
		/** @inheritDoc */
		public function end():void { }
		
		/** @inheritDoc */
		public function clear():void
		{ 
			var length:int = animations.length;
			for (var i:int = 0; i < length; i++) 
			{
				animations[i].clear();
			}
		}
		
		/** @inheritDoc */
		public function dispose():void
		{
			stop();
			
			for (var i:int = 0; i < length; i++) 
			{
				animations[i].dispose();
			}
			
			_animations = null;
			_target = null;
			_animation = null;
			_juggler = null;
			_easer = null;
			_progress = null;
			_completer = null;
			_length = 0;
		}
		
		/** Add animation to the list.
		 *  @param animation The animation instance. */
		public function add(animation:IAnimation):void
		{
			_animations.push(animation);
			_length++;
		}
		
		/** Remove animation from the list.
		 *  @param animation The animation instance. */
		public function remove(animation:IAnimation):void
		{
			_animations.splice(_animations.indexOf(animation), 1);
			_length--;
		}
		
		/** Remove all animations from the list. */
		public function removeAll():void
		{
			_animations.length = 0;
			_length = 0;
		}
	}
}
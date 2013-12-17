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
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;
	import com.firefly.core.async.helpers.Progress;
	import com.firefly.core.effects.easing.IEaser;
	import com.firefly.core.effects.easing.Linear;
	
	import starling.animation.Juggler;
	import starling.core.Starling;
	
	/** The animation class thats animates list of animation using sequence mode. 
	 * 
	 *  @see com.firefly.core.effects.Fade
	 *  @see com.firefly.core.effects.Rotate
	 *  @see com.firefly.core.effects.Scale
	 * 
	 *  @example The following code shows how to use this class to animate the list of animations in
	 *  loop and repeat delay:
	 *  <listing version="3.0">
	 *************************************************************************************
var quad:Quad = new Quad(140, 140, 0x000000);
addChild(quad);
 
var animation:Sequence = new Sequence(quad, 5, [new Fade(quad, 2, 0.1), new Rotate(quad, NaN, deg2rad(30)), new Fade(quad, NaN, 1)]);
animation.repeatDelay = 1;
animation.repeatCount = 0;
animation.play();
	 *************************************************************************************
	 *  </listing> */
	public class Sequence implements IAnimation
	{
		private var _juggler:Juggler;
		private var _target:Object;
		private var _duration:Number;
		private var _repeatCount:int;
		private var _repeatDelay:Number;
		private var _isPlaying:Boolean;
		private var _isPause:Boolean;
		private var _delay:Number;
		private var _easer:IEaser
		private var _completer:Completer;
		private var _progress:Progress
		private var _animation:IAnimation;
		private var _animations:Vector.<IAnimation>;
		private var _length:int;
		private var _currentIndex:uint;
		
	   /** Constructor.
		*  @param target Target of animation. Will be used for child animations if they don't have own targets.
		*  @param duration Duration in seconds. Will be used for calculation average duration for child
		*  animations if they don't have own specified durations.
		*  @param animations Array of animations to be played. */
		public function Sequence(target:Object, duration:Number=NaN, animations:Array=null)
		{
			_target = target;
			_duration = duration;
			
			_repeatCount = 1;
			_length = _repeatDelay = 0;;
			_completer = new Completer();
			_easer = new Linear();
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
		
		/** @inheritDoc */
		public function get isDefaultJuggler():Boolean { return _juggler == null; }
		public function get length():int { return _length; }
		
		/** @inheritDoc */
		public function get isPlaying():Boolean 
		{ 
			if(_currentIndex > -1 && _currentIndex < _length)
				return _animations[_currentIndex].isPlaying;
			else
				return false;
		}
		
		/** @inheritDoc */
		public function get isPause():Boolean 
		{ 
			if(_currentIndex > -1 && _currentIndex < _length)
				return _animations[_currentIndex].isPause;
			else
				return false;
		}
		
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
		
		/** @inheritDoc */
		public function get duration():Number { return _duration; }
		public function set duration(value:Number):void { _duration = value; }
		
		/** @inheritDoc */
		public function get delay():Number { return _delay; }
		public function set delay(value:Number):void { _delay = value; }
		
		/** @inheritDoc */
		public function get repeatCount():int { return _repeatCount; }
		public function set repeatCount(value:int):void { _repeatCount = value; }
		
		/** @inheritDoc */
		public function get repeatDelay():Number { return _repeatDelay; }
		public function set repeatDelay(value:Number):void { _repeatDelay = value; }
		
		/** @inheritDoc */
		public function get juggler():Juggler { return _juggler ? _juggler : Starling.juggler; }
		public function set juggler(value:Juggler):void { _juggler = value; }
		
		/** @inheritDoc */
		public function get easer():IEaser { return _easer; }
		public function set easer(value:IEaser):void { _easer = value; }
		
		/** @inheritDoc */
		public function play():Future
		{
			if(_isPlaying)
				stop();
			
			_currentIndex = -1;
			_progress = new Progress(0, _animations.length);
			calculateDuration();
			
			if (isNaN(_delay))
				playInternal();
			else
				Future.delay(_delay).then(playInternal);
			
			return _completer.future;
		}
		
		/** @inheritDoc */
		public function pause():void
		{
			if(_currentIndex > -1 && _currentIndex < _length)
				_animations[_currentIndex].pause();
		}
		
		/** @inheritDoc */
		public function resume():void
		{
			if(_currentIndex > -1 && _currentIndex < _length)
				_animations[_currentIndex].resume();
		}
		
		/** @inheritDoc */
		public function stop():void
		{
			if(_currentIndex > -1 && _currentIndex < _length)
				_animations[_currentIndex].stop();
		}
		
		/** @inheritDoc */
		public function end():void
		{
			if(_currentIndex > -1 && _currentIndex < _length)
			{
				for (var i:int = _currentIndex; i < _length; i++) 
				{
					_currentIndex = _length;
					_repeatCount = 1;
					_animations[i].end();
				}
			}
		}
		
		/** @inheritDoc */
		public function dispose():void
		{
			stop();
			
			for (var i:int = 0; i < _length; i++) 
			{
				_animations[i].dispose();
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
		
		/** @private */
		private function playInternal():void
		{
			_currentIndex++;
			
			if(_currentIndex < _length)
			{
				_animation = _animations[_currentIndex];
				
				if (_animation.repeatCount == 0)
					_animation.repeatCount = 1;
				
				if(!_animation.target)
					_animation.target = _target;
				
				if(!_animation.easer)
					_animation.easer = _easer;
				
				if(_animation.isDefaultJuggler)
					_animation.juggler = _juggler;
				
				_animation.play().then(playInternal).progress(onUpdate);
			}
			else if (_repeatCount == 0 || _repeatCount > 1)
			{
				Future.delay(_repeatDelay).then(play);
				
				if (_repeatCount > 1)
					_repeatCount--;
			}
			else
			{
				_animation = null;
				_progress = null;
				_completer.complete();
			}
		}
		
		/** @private */
		private function onUpdate(val:Number):void
		{
			_progress.current = _currentIndex + val;
			_progress.total = _length;
			_completer.sendProgress(_progress);
		}
		
		/** @private */
		private function calculateDuration():void
		{
			var tDuration:Number = _duration;
			var count:int = 0;
			var i:int;
			for (i = 0; i < _length; i++) 
			{
				_animation = animations[i];
				if (!isNaN(_animation.duration))
					tDuration -= _animation.duration;
				else
					count++;
			}
			
			if (tDuration > 0)
			{
				var avarageDuration:Number = tDuration/count;
				for (i = 0; i < _length; i++) 
				{
					_animation = animations[i];
					if (isNaN(_animation.duration))
						_animation.duration = avarageDuration;
				}
			}
		}
	}
}
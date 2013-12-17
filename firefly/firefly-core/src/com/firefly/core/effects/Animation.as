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
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.core.starling_internal;
	
	use namespace starling_internal;
	
	public class Animation implements IAnimation
	{
		private var _juggler:Juggler;
		private var _target:Object;
		private var _duration:Number;
		private var _repeatCount:int;
		private var _repeatDelay:Number;
		private var _isPlaying:Boolean;
		private var _isPause:Boolean;
		private var _delay:Number;
		private var _easer:IEaser;
		private var _completer:Completer;
		private var _progress:Progress
		private var _tween:Tween;
		
		public function Animation(target:Object, duration:Number = NaN)
		{
			this.target = target;
			this.duration = duration;
			
			_repeatCount = 1;
			_repeatDelay = 0;
			_completer = new Completer();
			_easer = new Linear();
		}
		
		public function get isDefaultJuggler():Boolean { return _juggler == null; }
		public function get isPlaying():Boolean { return _isPlaying; }
		public function get isPause():Boolean { return _isPause; }
		
		public function get target():Object { return _target; }
		public function set target(value:Object):void { _target = value; }
		
		public function get duration():Number { return _duration; }
		public function set duration(value:Number):void { _duration = value; }
		
		public function get delay():Number { return _delay; }
		public function set delay(value:Number):void { _delay = value; }
		
		public function get repeatCount():int { return _repeatCount; }
		public function set repeatCount(value:int):void { _repeatCount = value; }
		
		public function get repeatDelay():Number { return _repeatDelay; }
		public function set repeatDelay(value:Number):void { _repeatDelay = value; }
		
		public function get juggler():Juggler { return _juggler ? _juggler : Starling.juggler; }
		public function set juggler(value:Juggler):void { _juggler = value; }
		
		public function get easer():IEaser { return _easer; }
		public function set easer(value:IEaser):void { _easer = value; }
		
		public function play():Future
		{
			if(_isPlaying)
				stop();
			
			_tween = createTween();
			_progress = new Progress(0, _tween.totalTime);
			juggler.add(_tween);
			_isPlaying = true;
			
			return _completer.future;
		}
		
		public function pause():void
		{
			if(_isPlaying)
			{
				juggler.remove(_tween);
				_isPlaying = false;
				_isPause = true;
			}
		}
		
		public function resume():void
		{
			if (_isPause)
			{
				juggler.add(_tween);
				_isPlaying = true;
				_isPause = true;
			}
		}
		
		public function stop():void
		{
			if(_isPlaying)
			{
				juggler.remove(_tween);
				Tween.toPool(_tween);
				_progress = null;
				_tween = null;
				_isPlaying = _isPause = false;
			}
		}
		
		public function end():void
		{
			if(_isPlaying)
				stop();
			
			_completer.complete();
		}
		
		public function dispose():void
		{
			stop();
			
			_target = null;
			_juggler = null;
			_easer = null;
			_progress = null;
			_completer = null;
		}
		
		protected function createTween():Tween
		{
			var tween:Tween = Tween.fromPool(target, isNaN(duration) ? 1 : duration);
			tween.transitionFunc = _easer.ease;
			tween.onComplete = onComplete;
			tween.onUpdate = onUpdate;
			tween.repeatDelay = _repeatDelay;
			tween.repeatCount = _repeatCount;
			if (!isNaN(_delay))
				tween.delay = _delay;
			
			return tween;
		}
		
		protected function onUpdate():void
		{
			_progress.current = _tween.currentTime;
			_progress.total = _tween.totalTime;
			_completer.sendProgress(_progress);
		}
		
		protected function onComplete():void
		{
			stop();
			
			_completer.complete();
		}
	}
}
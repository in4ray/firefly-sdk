package com.firefly.core.effects
{
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;
	import com.firefly.core.async.helpers.Progress;
	import com.firefly.core.effects.easing.IEaser;
	import com.firefly.core.effects.easing.Linear;
	
	import starling.animation.Juggler;
	import starling.display.DisplayObject;
	
	public class Sequence implements IAnimation
	{
		private var _juggler:Juggler;
		private var _target:DisplayObject;
		private var _duration:Number;
		private var _loop:Boolean;
		private var _repeatCount:int;
		private var _repeatDelay:Number;
		private var _disposeOnComplete:Boolean;
		private var _isPlaying:Boolean;
		private var _isPause:Boolean;
		private var _delay:Number;
		private var _completer:Completer;
		private var _progress:Progress
		private var _currentIndex:uint;
		private var _animation:IAnimation;
		private var _length:int;
		private var _easer:IEaser
		private var _animations:Vector.<IAnimation> = new Vector.<IAnimation>();
		
		public function Sequence(target:DisplayObject, duration:Number = NaN, animations:Array = null)
		{
			this.target = target;
			this.duration = duration;
			
			_repeatCount = 1;
			_length = _repeatDelay = 0;;
			_completer = new Completer();
			_easer = new Linear();
			
			if (animations)
			{
				var length:int = animations.length;
				for (var i:int = 0; i < length; i++) 
				{
					add(animations[i]);
				}
			}
		}
		
		public function get isDefaultJuggler():Boolean { return _juggler == null; }
		public function get length():int { return _length; }
		
		public function get isPlaying():Boolean 
		{ 
			if(_currentIndex < _length)
				return _animations[_currentIndex].isPlaying;
			else
				return false;
		}
		
		public function get isPause():Boolean 
		{ 
			if(_currentIndex < _length)
				return _animations[_currentIndex].isPause;
			else
				return false;
		}
		
		public function get animations():Vector.<IAnimation> { return _animations; }
		public function set animations(value:Vector.<IAnimation>):void 
		{ 
			_animations = value;
			
			if (_animations)
				_length = _animations.length;
		}
		
		public function get target():DisplayObject { return _target; }
		public function set target(value:DisplayObject):void { _target = value; }
		
		public function get duration():Number { return _duration; }
		public function set duration(value:Number):void { _duration = value; }
		
		public function get delay():Number { return _delay; }
		public function set delay(value:Number):void { _delay = value; }
		
		public function get loop():Boolean { return _loop; }
		public function set loop(value:Boolean):void { _loop = value; }
		
		public function get repeatCount():int { return _repeatCount; }
		public function set repeatCount(value:int):void { _repeatCount = value; }
		
		public function get repeatDelay():Number { return _repeatDelay; }
		public function set repeatDelay(value:Number):void { _repeatDelay = value; }
		
		public function get disposeOnComplete():Boolean { return _disposeOnComplete; }
		public function set disposeOnComplete(value:Boolean):void { _disposeOnComplete = value; }
		
		public function get juggler():Juggler { return _juggler; }
		public function set juggler(value:Juggler):void { _juggler = value; }
		
		public function get easer():IEaser { return _easer; }
		public function set easer(value:IEaser):void { _easer = value; }
		
		public function play():Future
		{
			if(isPlaying)
				stop();
			
			_currentIndex = -1;
			_progress = new Progress(0, _animations.length);
			calculateDuration();
			playInternal();
			
			return _completer.future;
		}
		
		private function playInternal():void
		{
			_currentIndex++;
			
			if (_currentIndex == _length && _loop)
				_currentIndex = 0;
			
			if(_currentIndex < _length)
			{
				_animation = _animations[_currentIndex];
				
				if(!_animation.target)
					_animation.target = _target;
				
				if(!_animation.easer)
					_animation.easer = _easer;
				
				if(isNaN(_animation.delay))
					_animation.delay = delay;
				
				if(_animation.isDefaultJuggler)
					_animation.juggler = _juggler;
				
				if(isNaN(_animation.repeatCount))
					_animation.repeatCount = _repeatCount;
				
				if(isNaN(_animation.repeatDelay))
					_animation.repeatDelay = _repeatDelay;
				
				_animation.play().then(playInternal).progress(onProgress);
			}
			else
			{
				_animation = null;
				_progress = null;
				_completer.complete();
				
				if (_disposeOnComplete)
					dispose();
			}
		}
		
		public function pause():void
		{
			if(_currentIndex < _length)
				_animations[_currentIndex].pause();
		}
		
		public function resume():void
		{
			if(_currentIndex < _length)
				_animations[_currentIndex].resume();
		}
		
		public function stop():void
		{
			if(_currentIndex < _length)
				_animations[_currentIndex].stop();
		}
		
		public function end():void
		{
			if(_currentIndex < _length)
				_animations[_currentIndex].end();
		}
		
		public function dispose():void
		{
			stop();
			
			_target = null;
			_animation = null;
			_juggler = null;
			_easer = null;
			_progress = null;
			_completer = null;
			
			for (var i:int = 0; i < _length; i++) 
			{
				_animations[i].dispose();
			}
			
			animations.length = 0;
		}
		
		public function add(animation:IAnimation):void
		{
			_animations.push(animation);
			_length++;
		}
		
		public function remove(animation:IAnimation):void
		{
			_animations.splice(_animations.indexOf(animation), 1);
			_length--;
		}
		
		public function removeAll():void
		{
			_animations.length = 0;
			_length = 0;
		}
		
		private function onProgress(val:Number):void
		{
			_progress.current = _currentIndex + val;
			_progress.total = _length;
			_completer.sendProgress(_progress);
		}
		
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
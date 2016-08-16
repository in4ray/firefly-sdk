package com.firefly.core.effects.builder
{
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;
	import com.firefly.core.effects.IAnimation;
	import com.firefly.core.effects.easing.IEaser;
	
	import starling.animation.Juggler;
	
	/** Wrapper for animations in AnimationBuilder. */	
	public class ManagedAnimation implements IAnimation
	{
		/** Name of animation in AnimationBuilder */
		public var name:String;
		
		/** @private */	
		private var _animation:IAnimation;
		/** @private */	
		private var _builder:AnimationBuilder;
		/** @private */	
		private var _completer:Completer;
		/** @private */	
		private var _oneTime:Boolean;
		
		/** Constructor.
		 * @param builder Parrent AnimationBuilder */		
		public function ManagedAnimation(builder:AnimationBuilder)
		{
			_builder = builder;
		}
		
		/** @inheritDoc */	
		public function setTo(animation:IAnimation, oneTime:Boolean):void
		{
			_animation = animation;
			_oneTime = oneTime;
		}
		
		/** @inheritDoc */
		public function get target():Object
		{
			return _animation.target;
		}
		
		/** @inheritDoc */
		public function set target(value:Object):void
		{
			_animation.target = value;
		}
		
		/** @inheritDoc */
		public function get duration():Number
		{
			return _animation.duration;
		}
		
		/** @inheritDoc */
		public function set duration(value:Number):void
		{
			_animation..duration = value;
		}
		
		/** @inheritDoc */
		public function get delay():Number
		{
			return _animation.delay;
		}
		
		/** @inheritDoc */
		public function set delay(value:Number):void
		{
			_animation.delay = value;
		}
		
		/** @inheritDoc */
		public function get repeatCount():int
		{
			return _animation.repeatCount;
		}
		
		/** @inheritDoc */
		public function set repeatCount(value:int):void
		{
			_animation.repeatCount = value;
		}
		
		/** @inheritDoc */
		public function get repeatDelay():Number
		{
			return _animation.repeatDelay;
		}
		
		/** @inheritDoc */
		public function set repeatDelay(value:Number):void
		{
			_animation.repeatDelay = value;
		}
		
		/** @inheritDoc */
		public function get juggler():Juggler
		{
			return _animation.juggler;
		}
		
		/** @inheritDoc */
		public function set juggler(value:Juggler):void
		{
			_animation.juggler = value;
		}
		
		/** @inheritDoc */
		public function get easer():IEaser
		{
			return _animation.easer;
		}
		
		/** @inheritDoc */
		public function set easer(value:IEaser):void
		{
			_animation.easer = value;
		}
		
		/** @inheritDoc */
		public function get isPlaying():Boolean
		{
			return _animation.isPlaying;
		}
		
		/** @inheritDoc */
		public function get isPause():Boolean
		{
			return _animation.isPause;
		}
		
		/** @inheritDoc */
		public function get isDefaultJuggler():Boolean
		{
			return _animation.isDefaultJuggler;
		}
		
		/** @inheritDoc */
		public function play():Future
		{
			_completer = new Completer();
			_animation.play().then(complete);
			 
			return _completer.future;
		}
		
		/** @inheritDoc */
		private function complete():void
		{
			if(_oneTime)
			{
				_builder.removeAnimation(name);
				_animation.clear();
				_builder.cache(_animation);
			}
			
			_completer.complete();
		}
		
		/** @inheritDoc */
		public function pause():void
		{
			_animation.pause();
		}
		
		/** @inheritDoc */
		public function resume():void
		{
			_animation.resume();
		}
		
		/** @inheritDoc */
		public function stop():void
		{
			_animation.stop();
		}
		
		/** @inheritDoc */
		public function end():void
		{
			_animation.end();
		}
		
		/** @inheritDoc */
		public function clear():void
		{
			_animation.clear();
		}
		
		/** @inheritDoc */
		public function release():void
		{
			_animation.release();
		}
		
		/** @inheritDoc */
		public function dispose():void
		{
			_animation.dispose();
		}
	}
}
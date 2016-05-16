// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.effects.builder
{
	import com.firefly.core.async.Future;
	import com.firefly.core.effects.Animate;
	import com.firefly.core.effects.Fade;
	import com.firefly.core.effects.GroupAnimationBase;
	import com.firefly.core.effects.IAnimation;
	import com.firefly.core.effects.LayoutAnimation;
	import com.firefly.core.effects.Move;
	import com.firefly.core.effects.Parallel;
	import com.firefly.core.effects.Rotate;
	import com.firefly.core.effects.Scale;
	import com.firefly.core.effects.Sequence;
	import com.firefly.core.effects.easing.IEaser;
	import com.firefly.core.layouts.constraints.ILayoutUnits;
	import com.firefly.core.layouts.helpers.LayoutContext;
	import com.firefly.core.utils.Log;
	import com.firefly.core.utils.UIDGenerator;
	
	import flash.utils.Dictionary;
	
	import starling.animation.Juggler;
	import starling.core.Starling;

	/** Used to build animationsю */
	public class AnimationBuilder
	{
		/** @private */		
		private var _managedAnimations:Dictionary = new Dictionary();
		/** @private */
		private var _compositions:Vector.<GroupAnimationBase> = new Vector.<GroupAnimationBase>();
		/** @private */
		private var _target:Object;
		/** @private */
		private var _juggler:Juggler;
		/** @private */
		private var _delay:Number;
		/** @private */
		private var _animation:IAnimation;
		/** @private */
		private var _root:IAnimation;
		
		/** Constructor.
		 *  @param target Target instance of the component which will be animated. */		
		public function AnimationBuilder(target:Object=null)
		{
			_target = target;
		}
		
		/** Create neц animation builder instance.
		 *  @param target Target instance of the component which will be animated.
		 *  @return Animation builder. */		
		public static function init(target:Object=null):AnimationBuilder
		{
			return new AnimationBuilder(target);
		}
		
		private function addGroup(value:GroupAnimationBase):void
		{
			addAnimation(value)
			_compositions.push(value);
		}
		
		private function addAnimation(value:IAnimation):void
		{
			if(_compositions.length > 0)
				_compositions[_compositions.length-1].add(value);
			processAnimation(value);
		}
		
		private function processAnimation(value:IAnimation):void
		{
			if(!_root) 
				_root = value;
			else if(_compositions.length == 0)
				Log.warn("Previous animation will be removed! Use Sequence or Parallel to add several animations.");
			
			if(!isNaN(_delay))
			{
				value.delay = _delay;
				_delay = NaN;
			}
			
			if(_target)
			{
				value.target = _target;
				_target = null;
			}
			
			_animation = value;
		}
		
		private function clear():void
		{
			_target = null;
			_juggler = Starling.juggler;
			
			_compositions.length = 0;
			_delay = NaN;
			_animation = null;
			_root = null;
		}
		
		public function sequence():AnimationBuilder
		{
			addGroup(new Sequence(null));
			return this;
		}
		
		public function parallel():AnimationBuilder
		{
			addGroup(new Parallel(null)); 
			return this;
		}
		
		public function close():AnimationBuilder
		{
			_compositions.pop();
			return this;
		}
		
		public function move(toX:ILayoutUnits=null, toY:ILayoutUnits=null, fromX:ILayoutUnits=null, fromY:ILayoutUnits=null, context:LayoutContext=null):AnimationBuilder
		{
			addAnimation(new Move(null, NaN, toX, toY, fromX, fromY, context)); 
			return this;
		}
		
		public function layout(toValues:Array=null, fromValues:Array=null, layoutContext:LayoutContext=null):AnimationBuilder
		{
			addAnimation(new LayoutAnimation(null, NaN, toValues, fromValues, layoutContext)); 
			return this;
		}
		
		public function rotate(toRotation:Number=0, fromRotation:Number=NaN):AnimationBuilder
		{
			addAnimation(new Rotate(null, NaN, toRotation, fromRotation)); 
			return this;
		}
		
		public function scale( toScale:Number=1, fromScale:Number=NaN):AnimationBuilder
		{
			addAnimation(new Scale(null, NaN, toScale, fromScale));
			return this;
		}
		
		public function fade(toAlpha:Number=0, fromAlpha:Number=NaN):AnimationBuilder
		{
			addAnimation(new Fade(null, NaN, toAlpha, fromAlpha));
			return this;
		}
		
		public function animate(property:String="", toValue:Number=NaN, fromValue:Number=NaN):AnimationBuilder
		{
			addAnimation(new Animate(null, NaN, property, toValue, fromValue));
			return this;
		}
		
		public function delay(value:Number):AnimationBuilder
		{
			_delay = value;
			return this;
		}
		
		public function repeatCount(value:int):AnimationBuilder
		{
			if(_animation) 
				_animation.repeatCount = value;
			else
				Log.warn("RepeatCount will be ignored. Add animation first");
			
			return this;
		}
		
		public function repeatDelay(value:Number):AnimationBuilder
		{
			if(_animation) 
				_animation.repeatDelay = value;
			else
				Log.warn("RepeatDelay will be ignored. Add animation first");
			
			return this;
		}
		
		public function target(value:Object):AnimationBuilder
		{
			
			if(_animation) 
				_animation.target = value;
			else
				_target = value;
			
			return this;
		}
		
		public function easer(value:IEaser):AnimationBuilder
		{
			if(_animation) 
				_animation.easer = value;
			else
				Log.warn("Easer will be ignored. Add animation first.");
			
			return this;
		}
		
		public function duration(value:Number, prolonge:Boolean=false):AnimationBuilder
		{
			if(_animation) 
				_animation.duration = value;
			else
				Log.warn("Duration will be ignored. Add animation first.");
			
			return this;
		}
		
		public function juggler(value:Juggler):AnimationBuilder
		{
			_juggler = value;
			
			if(_animation) 
				_animation.juggler = value;
			
			return this;
		}
		
		public function play(name:String=""):Future
		{
			return manage(name).play();
		}
		
		public function build():IAnimation
		{
			var animation:IAnimation = _root;
			clear();
			return animation;
		}
		
		public function manage(name:String=""):IAnimation
		{
			var animation:IAnimation = _root;
			clear();
			
			if(name)
				_managedAnimations[name] = animation;
			else
				_managedAnimations[UIDGenerator.createUID()] = animation;
			
			return animation;
		}
		
		public function getAnimation(name:String):IAnimation
		{
			return _managedAnimations[name];
		}
		
		public function removeAnimation(name:String):void
		{
			delete _managedAnimations[name];
		}
		
		public function hasAnimation(name:String):Boolean
		{
			return _managedAnimations.hasOwnProperty(name);
		}
		
		public function pause():void
		{
			for (var k:Object in _managedAnimations) 
			{
				_managedAnimations[k].pause();
			}
		}
		
		public function resume():void
		{
			for (var k:Object in _managedAnimations) 
			{
				if(_managedAnimations[k].isPause)
					_managedAnimations[k].resume();
				else
					_managedAnimations[k].play();
			}
		}
	}
}
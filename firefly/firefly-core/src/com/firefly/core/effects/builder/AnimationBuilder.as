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
	
	import starling.animation.Juggler;
	import starling.core.Starling;

	public class AnimationBuilder
	{
		private var _target:Object;
		private var _juggler:Juggler;
		private var _delay:Number;
		private var _compositions:Vector.<GroupAnimationBase> = new Vector.<GroupAnimationBase>();
		private var _animation:IAnimation;
		private var _root:IAnimation;
		
		public function AnimationBuilder(target:Object=null)
		{
			_target = target;
		}
		
		public static function init(target:Object=null):AnimationBuilder
		{
			return new AnimationBuilder(target);
		}
		
		private function addGroup(value:GroupAnimationBase):void
		{
			_compositions.push(value);
			processAnimation(value);
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
			
			return this;
		}
		
		public function repeatDelay(value:Number):AnimationBuilder
		{
			if(_animation) 
				_animation.repeatDelay = value;
			
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
			
			return this;
		}
		
		public function duration(value:Number, prolonge:Boolean=false):AnimationBuilder
		{
			if(_animation) 
				_animation.duration = value;
			
			return this;
		}
		
		public function juggler(value:Juggler):AnimationBuilder
		{
			_juggler = value;
			
			if(_animation) 
				_animation.juggler = value;
			
			return this;
		}
		
		public function play():Future
		{
			var animation:IAnimation = _root;
			clear();
			
			return animation.play();
		}
		
		public function build():IAnimation
		{
			var animation:IAnimation = _root;
			clear();
			return animation;
		}
	}
}
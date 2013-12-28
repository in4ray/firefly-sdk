package com.firefly.core.effects
{
	import com.firefly.core.async.Future;
	
	import starling.animation.Tween;

	/** The animation class that changes property of object.
	 * 
	 *  @see com.firefly.core.effects.easing.Linear
	 *  @see com.firefly.core.effects.easing.EaseBase
	 *  @see com.firefly.core.effects.easing.StarlingEaser
	 *  @see com.firefly.core.effects.AnimationBase
	 * 
	 *  @example The following example shows how to use basic animation:
	 *  <listing version="3.0">
var animation:Animate = new Animate(myObject, 1000, "myProperty", 10, 0);
animation.play();
	 *  </listing> */
	public class Animate extends AnimationBase
	{
		private var _property:String;
		private var _fromValue:Number;
		private var _toValue:Number;
		
		/** Constructor.
		 *  @param target Target of the animation.
		 *  @param duration Duration in seconds.
		 *  @param property Target property that will be animated.
		 *  @param toValue Animate property to this value.
		 *  @param fromValue Animate property from this value. */
		public function Animate(target:Object, duration:Number=NaN, property:String="", toValue:Number=NaN, fromValue:Number=NaN)
		{
			super(target, duration);
			
			_property = property;
			_toValue = toValue;
			_fromValue = fromValue;
		}
		
		/** Property will be animated. */
		public function get property():String { return _property; }
		public function set property(value:String):void { _property = value; }
		
		/** Animate to value.
		 *  @default NaN */
		public function get toValue():Number { return _toValue; }
		public function set toValue(value:Number):void { _toValue = value; }
		
		/** Animate from value.
		 *  @default NaN */
		public function get fromValue():Number { return _fromValue; }
		public function set fromValue(value:Number):void { _fromValue = value; }
		
		/** @inheritDoc */
		override protected function createTween():Tween
		{
			var tween:Tween = super.createTween();
			tween.animate(_property, _toValue);
			
			return tween;
		}
		
		/** @inheritDoc */
		override public function play():Future
		{
			if(isNaN(_fromValue))
				_fromValue = target[_property];
			else
				target[_property] = _fromValue;	
			
			return super.play();
		}
		
		/** @inheritDoc */
		override public function end():void
		{
			target[_property] = _toValue;
			
			super.end();
		}
	}
}
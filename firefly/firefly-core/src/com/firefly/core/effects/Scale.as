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
	import com.firefly.core.async.Future;
	
	import starling.animation.Tween;
	
	/** The animation class that changes scale properties of the object. The animation changes <code>scaleX</code>
	 *  and <code>scaleY</code> properties.
	 *
	 *  @see com.firefly.core.effects.Animation
	 *  @see com.firefly.core.effects.easing.Linear
	 *  @see com.firefly.core.effects.easing.Back
	 *  @see com.firefly.core.effects.easing.Bounce
	 *  @see com.firefly.core.effects.easing.Circular
	 *  @see com.firefly.core.effects.easing.Elastic
	 *  @see com.firefly.core.effects.easing.Power
	 *  @see com.firefly.core.effects.easing.Sine
	 *  @see com.firefly.core.effects.easing.StarlingEaser
	 * 
	 *  @example The following code shows how to use this class to animate the scale of the object in 
	 *  loop with start delay:
	 *  <listing version="3.0">
	 *************************************************************************************
var quad:Quad = new Quad(140, 140, 0x000000);
addChild(quad);
 
var animation:Scale = new Scale(quad, 3, 2);
animation.delay = 0.5;
animation.repeatCount = 0;
animation.play();
	 *************************************************************************************
	 *  </listing> 
	 * 
	 * 	@example The following code shows how to use this class to animate the scale of the object with 
	 *  easer modification:
	 *  <listing version="3.0">
	 *************************************************************************************
var quad:Quad = new Quad(140, 140, 0x000000);
addChild(quad);
 
var animation:Scale = new Scale(quad, 3, 2);
animation.easer = new Bounce();
animation.play();
	 *************************************************************************************
	 *  </listing> 
	 * 
	 * 	@example The following code shows how to use this class to animate the scale of the object 
	 *  with Starling easer modification:
	 *  <listing version="3.0">
	 *************************************************************************************
var quad:Quad = new Quad(140, 140, 0x000000);
addChild(quad);
 
var animation:Scale = new Scale(quad, 3, 2);
animation.easer = new StarlingEaser(Transitions.EASE_IN);
animation.play();
	 *************************************************************************************
	 *  </listing> */
	public class Scale extends Animation
	{
		private var _fromScale:Number;
		private var _toScale:Number;
		
		/** Constructor.
		 *  @param target Target of the animation.
		 *  @param duration Duration in seconds.
		 *  @param toScale Animate to scale.
		 *  @param fromScale Animate from scale. */
		public function Scale(target:Object, duration:Number=NaN, toScale:Number=0, fromScale:Number=NaN)
		{
			super(target, duration);
			
			_toScale = toScale;
			_fromScale = fromScale;
		}
		
		/** Animate to scale. */
		public function get toScale():Number { return _toScale; }
		public function set toScale(value:Number):void { _toScale = value; }

		/** Animate from scale. */
		public function get fromScale():Number { return _fromScale; }
		public function set fromScale(value:Number):void { _fromScale = value; }
		
		/** @inheritDoc */
		override protected function createTween():Tween
		{
			var tween:Tween = super.createTween();
			tween.scaleTo(_toScale);
			
			return tween;
		}
		
		/** @inheritDoc */
		override public function play():Future
		{
			if(isNaN(_fromScale))
				_fromScale = target.scaleX;
			else
				target.scaleX = target.scaleY = _fromScale;	
			
			return super.play();
		}
		
		/** @inheritDoc */
		override public function end():void
		{
			target.scaleX = target.scaleY = _toScale;
			
			super.end();
		}
	}
}
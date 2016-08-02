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
	import com.firefly.core.async.Future;
	
	import starling.animation.Tween;

	/** The animation class that changes rotation property of the object.
	 * 
	 *  @see com.firefly.core.effects.easing.Linear
	 *  @see com.firefly.core.effects.easing.EaseBase
	 *  @see com.firefly.core.effects.easing.StarlingEaser
	 *  @see com.firefly.core.effects.AnimationBase
	 * 
	 *  @example The following code shows how to use this class to animate the rotation of the object in 
	 *  loop with start delay:
	 *  <listing version="3.0">
	 *************************************************************************************
var quad:Quad = new Quad(140, 140, 0x000000);
addChild(quad);
 
var animation:Rotate = new Rotate(quad, 3, deg2rad(30));
animation.delay = 0.5;
animation.repeatCount = 0;
animation.play();
	 *************************************************************************************
	 *  </listing> 
	 * 
	 * 	@example The following code shows how to use this class to animate the rotation of the object with 
	 *  easer modification:
	 *  <listing version="3.0">
	 *************************************************************************************
var quad:Quad = new Quad(140, 140, 0x000000);
addChild(quad);
 
var animation:Rotate = new Rotate(quad, 3, deg2rad(30));
animation.easer = new Bounce();
animation.play();
	 *************************************************************************************
	 *  </listing> 
	 * 
	 * 	@example The following code shows how to use this class to animate the rotation of the object 
	 *  with Starling easer modification:
	 *  <listing version="3.0">
	 *************************************************************************************
var quad:Quad = new Quad(140, 140, 0x000000);
addChild(quad);
 
var animation:Rotate = new Rotate(quad, 3, deg2rad(30));
animation.easer = new StarlingEaser(Transitions.EASE_IN);
animation.play();
	 *************************************************************************************
	 *  </listing> */
	public class Rotate extends AnimationBase
	{
		/** @private */
		private var _toRotation:Number;
		/** @private */
		private var _fromRotation:Number;
		
		/** Constructor.
		 *  @param target Target of the animation.
		 *  @param duration Duration in seconds.
		 *  @param toValue Animate to rotation (in radians).
		 *  @param fromValue Animate from rotation (in radians). */ 
		public function Rotate(target:Object, duration:Number=NaN, toRotation:Number=0, fromRotation:Number=NaN)
		{
			super(target, duration);
			
			_toRotation = toRotation;
			_fromRotation = fromRotation;
		}

		/** Animate to rotation (in radians).
		 *  @default 0 */
		public function get fromRotation():Number { return _fromRotation; }
		public function set fromRotation(value:Number):void { _fromRotation = value; }

		/** Animate from rotation (in radians).
		 *  @default NaN */
		public function get toRotation():Number { return _toRotation; }
		public function set toRotation(value:Number):void { _toRotation = value; }

		/** @inheritDoc */
		override protected function createTween():Tween
		{
			var tween:Tween = super.createTween();
			tween.rotateTo(_toRotation);
			
			return tween;
		}
		
		/** @inheritDoc */
		override public function play():Future
		{
			if (isNaN(_fromRotation))
				_fromRotation = target.rotation;
			else
				target.rotation = _fromRotation;
			
			return super.play();
		}
		
		/** @inheritDoc */
		override public function end():void
		{
			target.rotation = _toRotation;
			
			super.end();
		}
		
		/** @inheritDoc */
		override public function clear():void
		{
			_fromRotation = NaN;
			_toRotation = NaN;
			
			super.clear();
		}
	}
}
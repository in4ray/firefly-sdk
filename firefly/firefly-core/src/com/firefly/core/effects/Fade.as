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

	/** The animation class that changes alpha property of the object.
	 * 
	 *  @see com.firefly.core.effects.easing.Linear
	 *  @see com.firefly.core.effects.easing.EaseBase
	 *  @see com.firefly.core.effects.easing.StarlingEaser
	 *  @see com.firefly.core.effects.AnimationBase
	 * 
	 *  @example The following code shows how to use this class to animate the alpha of the object in 
	 *  loop with start delay:
	 *  <listing version="3.0">
	 *************************************************************************************
var quad:Quad = new Quad(140, 140, 0x000000);
addChild(quad);
 
var animation:Fade = new Fade(quad, 3, 0, 1);
animation.delay = 0.5;
animation.repeatCount = 0;
animation.play();
	 *************************************************************************************
	 *  </listing> 
	 * 
	 * 	@example The following code shows how to use this class to animate the alpha of the object with 
	 *  easer modification:
	 *  <listing version="3.0">
	 *************************************************************************************
var quad:Quad = new Quad(140, 140, 0x000000);
addChild(quad);
 
var animation:Fade = new Fade(quad, 3, 0, 1);
animation.easer = new Bounce();
animation.play();
	 *************************************************************************************
	 *  </listing> 
	 * 
	 * 	@example The following code shows how to use this class to animate the alpha of the object 
	 *  with Starling easer modification:
	 *  <listing version="3.0">
	 *************************************************************************************
var quad:Quad = new Quad(140, 140, 0x000000);
addChild(quad); 

var animation:Fade = new Fade(quad, 3, 0, 1);
animation.easer = new StarlingEaser(Transitions.EASE_IN);
animation.play();
	 *************************************************************************************
	 *  </listing> */
	public class Fade extends AnimationBase
	{
		/** @private */
		private var _toAlpha:Number;
		/** @private */
		private var _fromAlpha:Number;
		
		/** Constructor.
		 *  @param target Target of the animation.
		 *  @param duration Duration in seconds.
		 *  @param toAlpha Animate to alpha value.
		 *  @param fromAlpha Animate from alpha value. */
		public function Fade(target:Object, duration:Number=NaN, toAlpha:Number=0, fromAlpha:Number=NaN)
		{
			super(target, duration);
			
			_toAlpha = toAlpha;
			_fromAlpha = fromAlpha;
		}
		
		/** Animate to this alpha value.
		 *  @default 0 */
		public function get toAlpha():Number { return _toAlpha; }
		public function set toAlpha(value:Number):void { _toAlpha = value; }
		
		/** Animate from this alpha value.
		 *  @default NaN */
		public function get fromAlpha():Number { return _fromAlpha; }
		public function set fromAlpha(value:Number):void { _fromAlpha = value; }

		/** @inheritDoc */
		override protected function createTween():Tween
		{
			var tween:Tween = super.createTween();
			tween.fadeTo(_toAlpha);
			
			return tween;
		}
		
		/** @inheritDoc */
		override public function play():Future
		{
			if (isNaN(_fromAlpha))
				_fromAlpha = target.alpha;
			else
				target.alpha = _fromAlpha;
			
			return super.play();
		}
		
		/** @inheritDoc */
		override public function end():void
		{
			target.alpha = _toAlpha;
			
			super.end();
		}
	}
}
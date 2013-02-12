// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.effects
{
	import com.in4ray.gaming.components.IVisualElement;
	
	import starling.animation.Tween;

	/**
	 * Animation that changes alpha property 
	 */	
	public class Fade extends AnimationBase
	{
		/**
		 * Constructor.
		 *  
		 * @param target Target of animation.
		 * @param duration Duration in milliseconds.
		 * @param toAlpha Animate to this alpha value.
		 * @param fromAlpha Animate from this alpha value.
		 */		
		public function Fade(target:IVisualElement=null, duration:Number=NaN, toAlpha:Number=NaN, fromAlpha:Number = NaN)
		{
			super(target, duration);
			
			this.toAlpha = toAlpha;
			this.fromAlpha = fromAlpha;
		}
		
		/**
		 * Animate from this alpha value.
		 */		
		public var fromAlpha:Number;
		
		/**
		 * Animate to this alpha value. 
		 */		
		public var toAlpha:Number = 1;
		
		/**
		 * @inheritDoc 
		 */		
		override protected function createTween():Tween
		{
			var tween:Tween = super.createTween();
			tween.fadeTo(toAlpha);
			
			return tween;
		}
		
		/**
		 * @inheritDoc 
		 */	
		override public function play():void
		{
			if(!isNaN(fromAlpha))
				target.alpha = fromAlpha;
			super.play();
		}
		
		/**
		 * @inheritDoc 
		 */	
		override public function end():void
		{
			target.alpha = toAlpha;
			
			super.end();
		}
	}
}
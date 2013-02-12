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
	 * Animation that scales target. 
	 */	
	public class Scale extends AnimationBase
	{
		/**
		 * Constructor.
		 *  
		 * @param target Target of animation.
		 * @param duration Duration in milliseconds.
		 * @param toScale Animate to scale.
		 * @param fromScale Animate from scale.
		 */		
		public function Scale(target:IVisualElement=null, duration:Number=NaN, toScale:Number=NaN, fromScale:Number = NaN)
		{
			super(target, duration);
			
			this.toScale = toScale;
			this.fromScale = fromScale;
		}
		
		/**
		 * Animate from scale. 
		 */		
		public var fromScale:Number;
		
		/**
		 * Animate to scale.
		 * 
		 * @default 1. 
		 */		
		public var toScale:Number = 1;
		
		/**
		 * @inheritDoc 
		 */		
		override protected function createTween():Tween
		{
			var tween:Tween = super.createTween();
			tween.scaleTo(toScale);
			
			return tween;
		}
		
		/**
		 * @inheritDoc 
		 */	
		override public function play():void
		{
			if(!isNaN(fromScale))
				target.scaleX = target.scaleY = fromScale;
			super.play();
		}
		
		/**
		 * @inheritDoc 
		 */	
		override public function end():void
		{
			target.scaleX = target.scaleY = toScale;
			
			super.end();
		}
	}
}
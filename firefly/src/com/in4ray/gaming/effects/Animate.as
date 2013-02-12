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
	import starling.animation.Tween;

	/**
	 * Basic animation class. 
	 * 
	 * @example The following example shows how to use basic animation:
	 * <listing version="3.0">
var animation:Animate = new Animate(myObject, 1000, "myProperty", 10, 0);
animation.play();
	 * </listing>
	 */	
	public class Animate extends AnimationBase
	{
		/**
		 * Constructor.
		 *  
		 * @param target Target of animation.
		 * @param duration Duration in milliseconds.
		 * @param property Target property that will be animated.
		 * @param toValue Animate property to this value.
		 * @param fromValue Animate property from this value.
		 */		
		public function Animate(target:Object=null, duration:Number=NaN, property:String="", toValue:Number=NaN, fromValue:Number = NaN)
		{
			super(target, duration);
			
			this.property = property;
			this.toValue = toValue;
			this.fromValue = fromValue;
		}
		
		/**
		 * Target property that will be animated. 
		 */		
		public var property:String;
		
		/**
		 * Animate property from this value.
		 */		
		public var fromValue:Number;
		
		/**
		 * Animate property to this value.
		 */		
		public var toValue:Number = 1;
		
		/**
		 * @inheritDoc 
		 */		
		override protected function createTween():Tween
		{
			var tween:Tween = super.createTween();
			
			tween.animate(property, toValue);
			
			return tween;
		}
		
		/**
		 * @inheritDoc 
		 */
		override public function play():void
		{
			if(!isNaN(fromValue))
				target[property] = fromValue;
			
			super.play();
		}
		
		/**
		 * @inheritDoc 
		 */
		override public function end():void
		{
			target[property] = toValue;
			
			super.end();
		}
	}
}
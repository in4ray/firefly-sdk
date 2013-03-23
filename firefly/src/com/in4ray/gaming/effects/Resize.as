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
	import com.in4ray.gaming.layouts.$height;
	import com.in4ray.gaming.layouts.$width;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;

	/**
	 * Animation that resize target changing width and height. 
	 */	
	public class Resize extends AnimationBase
	{
		/**
		 * Constructor.
		 *  
		 * @param target Target of animation.
		 * @param duration Duration in miliseconds.
		 * @param toWidth Animate to width.
		 * @param toHeight Animate to height.
		 * @param fromWidth Animate from width.
		 * @param fromHeight Animate from height.
		 */		
		public function Resize(target:IVisualElement=null, duration:Number=NaN, toWidth:Number=NaN, toHeight:Number=NaN, fromWidth:Number = NaN, fromHeight:Number = NaN)
		{
			super(target, duration);
			
			this.toWidth = toWidth;
			this.toHeight = toHeight;
			this.fromWidth = fromWidth;
			this.fromHeight = fromHeight;
		}
		
		/**
		 * Animate from width. 
		 */		
		public var fromWidth:Number;
		
		/**
		 *  Animate to width. 
		 */		
		public var toWidth:Number;
		
		/**
		 * Animate from height. 
		 */		
		public var fromHeight:Number;
		
		/**
		 * Animate to height. 
		 */		
		public var toHeight:Number;
		
		/**
		 * @inheritDoc 
		 */		
		override protected function createTween():Tween
		{
			var tween:Tween = new Tween(this, (isNaN(duration) ? 1000 : duration)/1000, (transition ? transition : Transitions.LINEAR));
			
			if(!isNaN(delay))
				tween.delay = delay/1000;
			tween.onComplete = tweenComplete;
			if(!isNaN(toWidth))
				tween.animate("valueWidth", toWidth);
			if(!isNaN(toHeight))
				tween.animate("valueHeight", toHeight);
			
			return tween;
		}
		
		/**
		 * @private 
		 */		
		protected function get targetElement():IVisualElement
		{
			return target as IVisualElement;
		}
		
		/**
		 * @private 
		 */
		public function get valueWidth():Number
		{
			return targetElement.getLayout($width).value;
		}
		
		/**
		 * @private 
		 */
		public function set valueWidth(value:Number):void
		{
			targetElement.setLayoutValue($width, value);
		}
		
		/**
		 * @private 
		 */
		public function get valueHeight():Number
		{
			return targetElement.getLayout($height).value;
		}
		
		/**
		 * @private 
		 */
		public function set valueHeight(value:Number):void
		{
			targetElement.setLayoutValue($height, value);
		}
		
		/**
		 * @inheritDoc 
		 */	
		override public function play():void
		{
			if(!isNaN(fromWidth))
				valueWidth = fromWidth;
			
			if(!isNaN(fromHeight))
				valueHeight = fromHeight;
			
			super.play();
		}
		
		/**
		 * @inheritDoc 
		 */	
		override public function end():void
		{
			valueWidth = toWidth;
			valueHeight = toHeight;
			
			super.end();
		}
	}
}
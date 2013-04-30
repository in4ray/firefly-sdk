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
	import com.in4ray.gaming.layouts.ILayout;
	import com.in4ray.gaming.layouts.LayoutMock;
	
	import flash.geom.Point;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	
	/**
	 * Animation that moves object, changing $x and $y layout values. 
	 */	
	public class Move2 extends AnimationBase
	{
		/**
		 * Constructor.
		 *  
		 * @param target Target of animation.
		 * @param duration Duration in milliseconds.
		 * @param toX Animate to x layout.
		 * @param toY Animate to y layout.
		 * @param fromX Animate from x layout.
		 * @param fromY Animate from y layout.
		 */		
		public function Move2(target:IVisualElement=null, duration:Number=NaN, toX:ILayout=null, toY:ILayout=null, fromX:ILayout=null, fromY:ILayout=null)
		{
			super(target, duration);
			
			this.toX = toX;
			this.toY = toY;
			this.fromX = fromX;
			this.fromY = fromY;
		}
		
		/**
		 * Animate from x layout. 
		 */		
		public var fromX:ILayout;
		
		/**
		 * Animate from x position. 
		 */		
		private var fromXValue:Number;
		
		/**
		 * Animate to x layout.
		 */		
		public var toX:ILayout;
		
		/**
		 * Animate to x position.
		 */		
		private var toXValue:Number;
		
		/**
		 * Animate from y layout.
		 */		
		public var fromY:ILayout;
		
		/**
		 * Animate from y position.
		 */		
		private var fromYValue:Number;
		
		/**
		 * Animate to y layout.
		 */		
		public var toY:ILayout;
		
		/**
		 * Animate to y position.
		 */		
		private var toYValue:Number;
		
		/**
		 * Move speed px per second.
		 */		
		public var speed:Number;
		
		/**
		 * @inheritDoc 
		 */		
		override protected function createTween():Tween
		{
			if(fromX)
				fromXValue = computeValue(fromX).x;
			if(fromY)
				fromYValue = computeValue(fromY).y;
			if(toX)
				toXValue = computeValue(toX).x;
			if(toY)
				toYValue = computeValue(toY).y;
			
			if(!isNaN(speed))
			{
				var frX:Number = !isNaN(fromXValue) ? fromXValue : targetElement.x;
				var frY:Number = !isNaN(fromYValue) ? fromYValue : targetElement.y;
				
				var distX:Number = 0;
				var distY:Number = 0;
				
				if(!isNaN(toXValue))
					distX = toXValue - frX;
				
				if(!isNaN(toYValue))
					distY = toYValue - frY;
				
				duration = new Point(toXValue - frX, toYValue - frY).length/speed; 
			}
			
			var tween:Tween = new Tween(this, (isNaN(duration) ? 1000 : duration)/1000, (transition ? transition : Transitions.LINEAR));
			
			if(!isNaN(delay))
				tween.delay = delay/1000;
			tween.onComplete = tweenComplete;
			if(!isNaN(toXValue))
				tween.animate("valueX", toXValue);
			if(!isNaN(toYValue))
				tween.animate("valueY", toYValue);
			
			return tween;
		}
		
		
		private function computeValue(layout:ILayout):LayoutMock
		{
			var mock:LayoutMock = new LayoutMock(target.parent);
			mock.addLayout(layout).layout();
			
			return mock;
		}
		
		
		/**
		 * @private 
		 */	
		protected function get targetElement():IVisualElement
		{
			return target as IVisualElement;
		}
		
		public function get valueX():Number
		{
			return targetElement.x;
		}
		
		/**
		 * @private 
		 */	
		public function set valueX(value:Number):void
		{
			targetElement.setActualPosition(value, NaN);
		}
		
		/**
		 * @private 
		 */	
		public function get valueY():Number
		{
			return targetElement.y;
		}
		
		/**
		 * @private 
		 */	
		public function set valueY(value:Number):void
		{
			targetElement.setActualPosition(NaN, value);
		}
		
		/**
		 * @inheritDoc 
		 */
		override public function play():void
		{
			if(!isNaN(fromXValue))
				valueX = fromXValue;
			
			if(!isNaN(fromYValue))
				valueY = fromYValue;
			
			super.play();
		}
		
		/**
		 * @inheritDoc 
		 */
		override public function end():void
		{
			if(!isNaN(toXValue))
				valueX = toXValue;
			
			if(!isNaN(toYValue))
				valueY = toYValue;
			
			super.end();
		}
	}
}


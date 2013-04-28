package com.in4ray.gaming.effects
{
	import com.in4ray.gaming.components.IVisualElement;
	
	import starling.animation.Tween;

	public class Rotate extends AnimationBase
	{
		/**
		 * Constructor.
		 *  
		 * @param target Target of animation.
		 * @param duration Duration in milliseconds.
		 * @param toValue Animate to rotation.
		 * @param fromValue Animate from rotation.
		 * @param aroundCenter Rotate tarhet around its center.
		 */		
		public function Rotate(target:IVisualElement=null, duration:Number=NaN, toValue:Number=NaN, fromValue:Number = NaN, aroundCenter:Boolean = true)
		{
			super(target, duration);
			this.aroundCenter = aroundCenter;
			
			this.toValue = toValue;
			this.fromValue = fromValue;
		}
		
		/**
		 * Animate from rotation. 
		 */		
		public var fromValue:Number;
		
		/**
		 * Animate to ritation.
		 * 
		 * @default 0. 
		 */		
		public var toValue:Number = 0;

		/**
		 * Rotate around center. 
		 */		
		public var aroundCenter:Boolean;
		
		/**
		 * @inheritDoc 
		 */		
		override protected function createTween():Tween
		{
			var tween:Tween = super.createTween();
			tween.animate("rotation", toValue);
			
			return tween;
		}
		
		/**
		 * @inheritDoc 
		 */	
		override public function play():void
		{
			if(!isNaN(fromValue))
				target.rotation = fromValue;
			
			if(aroundCenter)
				target.setActualPivots(target.width/2, target.height/2);
			
			super.play();
		}
		
		/**
		 * @inheritDoc 
		 */	
		override public function end():void
		{
			target.rotation = toValue;
			
			super.end();
		}
	}
}

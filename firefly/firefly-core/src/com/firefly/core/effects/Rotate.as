package com.firefly.core.effects
{
	import com.firefly.core.async.Future;
	
	import starling.animation.Tween;
	import starling.display.DisplayObject;
	
	public class Rotate extends Animation
	{
		private var _toRotation:Number = 0;
		private var _fromRotation:Number;
		
		public function Rotate(target:DisplayObject, duration:Number = 1, toRotation:Number = 0, fromRotation:Number = NaN)
		{
			super(target, duration);
			
			this.toRotation = toRotation;
			this.fromRotation = fromRotation;
		}

		public function get fromRotation():Number { return _fromRotation; }
		public function set fromRotation(value:Number):void { _fromRotation = value; }

		public function get toRotation():Number { return _toRotation; }
		public function set toRotation(value:Number):void { _toRotation = value; }

		override protected function createTween():Tween
		{
			var tween:Tween = super.createTween();
			tween.animate("rotation", toRotation);
			
			return tween;
		}
		
		override public function play():Future
		{
			if(!isNaN(fromRotation))
				target.rotation = fromRotation;
			
			return super.play();
		}
		
		override public function end():void
		{
			target.rotation = toRotation;
			
			super.end();
		}
	}
}
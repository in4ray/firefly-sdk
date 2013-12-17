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
	
	public class Scale extends Animation
	{
		private var _fromScale:Number;
		private var _toScale:Number;
		
		public function Scale(target:Object, duration:Number = NaN, toScale:Number = 0, fromScale:Number = NaN)
		{
			super(target, duration);
			
			this.toScale = toScale;
			this.fromScale = fromScale;
		}
		
		public function get toScale():Number { return _toScale; }
		public function set toScale(value:Number):void { _toScale = value; }

		public function get fromScale():Number { return _fromScale; }
		public function set fromScale(value:Number):void { _fromScale = value; }
		
		override protected function createTween():Tween
		{
			var tween:Tween = super.createTween();
			tween.scaleTo(_toScale);
			
			return tween;
		}
		
		override public function play():Future
		{
			if(isNaN(_fromScale))
				_fromScale = target.scaleX;
			else
				target.scaleX = target.scaleY = _fromScale;	
			
			return super.play();
		}
		
		override public function end():void
		{
			target.scaleX = target.scaleY = _toScale;
			
			super.end();
		}
	}
}
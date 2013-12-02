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

	public class Fade extends Animation
	{
		private var _toAlpha:Number;
		private var _fromAlpha:Number;
		
		public function Fade(target:Object, duration:Number = NaN, toAlpha:Number = NaN, fromAlpha:Number = NaN)
		{
			super(target, duration);
			
			this.toAlpha = toAlpha;
			this.fromAlpha = fromAlpha;
		}
		
		public function get toAlpha():Number { return _toAlpha; }
		public function set toAlpha(value:Number):void { _toAlpha = value; }
		
		public function get fromAlpha():Number { return _fromAlpha; }
		public function set fromAlpha(value:Number):void { _fromAlpha = value; }

		override protected function createTween():Tween
		{
			var tween:Tween = super.createTween();
			tween.fadeTo(_toAlpha);
			
			return tween;
		}
		
		override public function play():Future
		{
			if(!isNaN(fromAlpha))
				target.alpha = fromAlpha;
			
			return super.play();
		}
		
		override public function end():void
		{
			target.alpha = _toAlpha;
			
			super.end();
		}
	}
}
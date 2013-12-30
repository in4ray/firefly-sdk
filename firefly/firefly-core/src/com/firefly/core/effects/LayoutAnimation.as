package com.firefly.core.effects
{
	import com.firefly.core.async.Future;
	import com.firefly.core.layouts.constraints.ILayoutUnits;
	
	import starling.animation.Tween;

	public class LayoutAnimation extends AnimationBase
	{
		private var _toValues:Vector.<ILayoutUnits>;
		private var _fromValues:Vector.<ILayoutUnits>;
		
		public function LayoutAnimation(target:Object, duration:Number=NaN, toValues:Vector.<ILayoutUnits>=null, fromValues:Vector.<ILayoutUnits>=null)
		{
			super(target, duration);
			
			_toValues = toValues;
			_fromValues = _fromValues;
		}
		
		public function get toValues():Vector.<ILayoutUnits> { return _toValues }
		public function set toValues(value:Vector.<ILayoutUnits>):void { _toValues = value } 
		
		public function get fromValues():Vector.<ILayoutUnits> { return _fromValues }
		public function set fromValues(value:Vector.<ILayoutUnits>):void { _fromValues = value }
		
		/** @inheritDoc */
		override protected function createTween():Tween
		{
			var tween:Tween = super.createTween();
			//tween.animate(,);
			
			return tween;
		}
		
		/**
		 * @inheritDoc 
		 */
		override public function play():Future
		{
			return super.play();
		}
		
		/**
		 * @inheritDoc 
		 */
		override public function end():void
		{
			
			super.end();
		}
	}
}
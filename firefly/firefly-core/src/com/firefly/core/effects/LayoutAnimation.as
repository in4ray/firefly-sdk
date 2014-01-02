package com.firefly.core.effects
{
	import com.firefly.core.async.Future;
	import com.firefly.core.layouts.constraints.ILayoutUnits;
	
	import starling.animation.Tween;

	public class LayoutAnimation extends AnimationBase
	{
		private var _toValues:Vector.<ILayoutUnits>;
		private var _fromValues:Vector.<ILayoutUnits>;
		
		public function LayoutAnimation(target:Object, duration:Number=NaN, toValues:Array=null, fromValues:Array=null)
		{
			super(target, duration);
			
			_toValues = new Vector.<ILayoutUnits>();
			_fromValues = new Vector.<ILayoutUnits>();
			
			var length:int;
			var i:int;
			if (toValues)
			{
				length = toValues.length;
				for (i = 0; i < length; i++) 
				{
					addToValue(toValues[i]);
				}
			}
			
			if (fromValues)
			{
				length = fromValues.length;
				for (i = 0; i < length; i++) 
				{
					addFromValue(fromValues[i]);
				}
			}
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
		
		public function addToValue(layoutUnit:ILayoutUnits):void
		{
			_toValues.push(layoutUnit);
		}
		
		public function addFromValue(layoutUnit:ILayoutUnits):void
		{
			_fromValues.push(layoutUnit);
		}
		
		public function removeToValue(layoutUnit:ILayoutUnits):void
		{
			_toValues.splice(_toValues.indexOf(layoutUnit), 1);
		}
		
		public function removeFromValue(layoutUnit:ILayoutUnits):void
		{
			_fromValues.splice(_fromValues.indexOf(layoutUnit), 1);
		}
		
		public function removeAllToValues():void
		{
			_toValues.length = 0;
		}
		
		public function removeAllFromValues():void
		{
			_fromValues.length = 0;
		}
	}
}
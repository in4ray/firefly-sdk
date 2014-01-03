package com.firefly.core.effects
{
	import com.firefly.core.Firefly;
	import com.firefly.core.firefly_internal;
	import com.firefly.core.async.Future;
	import com.firefly.core.layouts.constraints.$height;
	import com.firefly.core.layouts.constraints.$pivotX;
	import com.firefly.core.layouts.constraints.$pivotY;
	import com.firefly.core.layouts.constraints.$width;
	import com.firefly.core.layouts.constraints.$x;
	import com.firefly.core.layouts.constraints.$y;
	import com.firefly.core.layouts.constraints.ILayoutUnits;
	import com.firefly.core.layouts.helpers.LayoutContext;
	import com.firefly.core.layouts.helpers.LayoutElement;
	
	import starling.animation.Tween;
	
	use namespace firefly_internal;

	/** The animation class that changes geometry properties of the object (x, y, width, height, pivotX and pivotY). */
	public class LayoutAnimation extends AnimationBase
	{
		private var _toValues:Array;
		private var _fromValues:Array;
		private var _layoutContext:LayoutContext;
		private var _toLayoutElement:LayoutElement;
		private var _fromLayoutElement:LayoutElement;
		
		public function LayoutAnimation(target:Object, duration:Number=NaN, toValues:Array=null, fromValues:Array=null, layoutContext:LayoutContext=null)
		{
			super(target, duration);
			
			_toValues = toValues;
			_fromValues = fromValues;
			_layoutContext = layoutContext;
			_toLayoutElement = new LayoutElement();
			_fromLayoutElement = new LayoutElement();
		}
		
		public function get toValues():Array { return _toValues }
		public function set toValues(value:Array):void { _toValues = value } 
		
		public function get fromValues():Array { return _fromValues }
		public function set fromValues(value:Array):void { _fromValues = value }
		
		public function get layoutContext():LayoutContext { return _layoutContext }
		public function set layoutContext(value:LayoutContext):void { _layoutContext = value }
		
		/** @inheritDoc */
		override protected function createTween():Tween
		{
			var tween:Tween = super.createTween();
			
			if (_toLayoutElement._xChanged)
				tween.animate("x", _toLayoutElement.x);
			if (_toLayoutElement._yChanged)
				tween.animate("y", _toLayoutElement.y);
			if (_toLayoutElement._widthChanged)
				tween.animate("width", _toLayoutElement.width);
			if (_toLayoutElement._heightChanged)
				tween.animate("height", _toLayoutElement.height);
			if (_toLayoutElement._pivotXChanged)
				tween.animate("pivotX", _toLayoutElement.pivotX);
			if (_toLayoutElement._pivotYChanged)
				tween.animate("pivotY", _toLayoutElement.pivotY);
			
			return tween;
		}
		
		/** @inheritDoc  */
		override public function play():Future
		{
			if (!_layoutContext)
				_layoutContext = Firefly.current.layoutContext;
			
			if (_fromValues && _fromValues.length > 0)
				_fromLayoutElement.layout(_layoutContext, target, _fromValues);
			if (_toValues && _toValues.length > 0)
				_toLayoutElement.layout(_layoutContext, target, _toValues, false);
			
			if (!_fromValues)
				_fromValues = [];
				
			if(_toLayoutElement._xChanged && !_fromLayoutElement._xChanged)
				_fromValues.push($x(target.x).px);
			if(_toLayoutElement._yChanged && !_fromLayoutElement._yChanged)
				_fromValues.push($y(target.y).px);
			if(_toLayoutElement._widthChanged && !_fromLayoutElement._widthChanged)
				_fromValues.push($width(target.width).px);
			if(_toLayoutElement._heightChanged && !_fromLayoutElement._heightChanged)
				_fromValues.push($height(target.height).px);
			if(_toLayoutElement._pivotXChanged && !_fromLayoutElement._pivotXChanged)
				_fromValues.push($pivotX(target.pivotX).px);
			if(_toLayoutElement._pivotYChanged && !_fromLayoutElement._pivotYChanged)
				_fromValues.push($pivotY(target.pivotY).px);
			
			return super.play();
		}
		
		/** @inheritDoc */
		override public function end():void
		{
			_toLayoutElement.apply();
			
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
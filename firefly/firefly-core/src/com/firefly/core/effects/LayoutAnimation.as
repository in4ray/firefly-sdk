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

	/** The animation class that changes geometry properties of the object (x, y, width, height, pivotX and pivotY).
	 *  
	 *  @see com.firefly.core.effects.easing.Linear
	 *  @see com.firefly.core.effects.easing.EaseBase
	 *  @see com.firefly.core.effects.easing.StarlingEaser
	 *  @see com.firefly.core.effects.AnimationBase
	 * 
	 *  @example The following code shows how to use this class to animate the x, y of the object
	 *  using context pixels layout units:
	 *  <listing version="3.0">
	 *************************************************************************************
var layout:Layout = new Layout(this);
var quad:Quad = new Quad(100, 100, 0x000000);
layout.addElement(quad, $x(20).cpx, $y(20).cpx, $width(100).cpx, $height(100).cpx);
 
var animation:LayoutAnimation = new LayoutAnimation(quad, 3, [$x(300).cpx, $y(200).cpx]);
animation.play();
	 *************************************************************************************
	 *  </listing> 
	 * 
	 * 	@example The following code shows how to use this class to animate the width, height of the object with 
	 *  easer modification using percentage layout units:
	 *  <listing version="3.0">
	 *************************************************************************************
var layout:Layout = new Layout(this);
var quad:Quad = new Quad(100, 100, 0x000000);
layout.addElement(quad, $left(20).cpx, $top(20).cpx, $width(100).cpx, $height(100).cpx);
 
var animation:LayoutAnimation = new LayoutAnimation(quad, 3, 2, [$width(50).pct, $height(50).pct]);
animation.easer = new Bounce();
animation.play();
	 *************************************************************************************
	 *  </listing> 
	 * 
	 * 	@example The following code shows how to use this class to animate the x, y, width, height of the object 
	 *  using pixels layout units amd $top, $bottom, $right, $left constraints:
	 *  <listing version="3.0">
	 *************************************************************************************
var layout:Layout = new Layout(this);
var quad:Quad = new Quad(100, 100, 0x000000);
layout.addElement(quad, $left(20).px, $top(20).px, $width(100).px, $height(100).px);
 
var animation:LayoutAnimation = new LayoutAnimation(quad, 3, [$top(50).px, $bottom(50).px, $left(50).px, $right(50).px]);
animation.play();
	 *************************************************************************************
	 *  </listing> */
	public class LayoutAnimation extends AnimationBase
	{
		private var _toValues:Array;
		private var _fromValues:Array;
		private var _layoutContext:LayoutContext;
		private var _toLayoutElement:LayoutElement;
		private var _fromLayoutElement:LayoutElement;
		
		/** Constructor.
		 *  @param target Target of the animation.
		 *  @param duration Duration in seconds.
		 *  @param toValues Layout units will be used for calculation to which values need to animate.
		 *  @param fromValues Layout units will be used for calculation from which values need to animate.
		 *  @param layoutContext Layout context that be used for layout calculation. */
		public function LayoutAnimation(target:Object, duration:Number=NaN, toValues:Array=null, fromValues:Array=null, 
										layoutContext:LayoutContext=null)
		{
			super(target, duration);
			
			_toValues = toValues;
			_fromValues = fromValues;
			_layoutContext = layoutContext;
			_toLayoutElement = new LayoutElement();
			_fromLayoutElement = new LayoutElement();
		}
		
		/** Layout units will be used for calculation to which values need to animate. */
		public function get toValues():Array { return _toValues }
		public function set toValues(value:Array):void { _toValues = value } 
		
		/** Layout units will be used for calculation from which values need to animate. */
		public function get fromValues():Array { return _fromValues }
		public function set fromValues(value:Array):void { _fromValues = value }
		
		/** Layout context that be used for layout calculation. */
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
		
		/** Add layout unit is using for calculation to which values need to animate.
		 *  @param layoutUnit Layout unit.*/
		public function addToLayoutUnit(layoutUnit:ILayoutUnits):void
		{
			_toValues.push(layoutUnit);
		}
		
		/** Add layout unit is using for calculation from which values need to animate.
		 *  @param layoutUnit Layout unit.*/
		public function addFromLayoutUnit(layoutUnit:ILayoutUnits):void
		{
			_fromValues.push(layoutUnit);
		}
		
		/** Remove layout unit is using for calculation to which values need to animate.
		 *  @param layoutUnit Layout unit.*/
		public function removeToLayoutUnit(layoutUnit:ILayoutUnits):void
		{
			_toValues.splice(_toValues.indexOf(layoutUnit), 1);
		}
		
		/** Remove layout unit is using for calculation from which values need to animate.
		 *  @param layoutUnit Layout unit.*/
		public function removeFromLayoutUnit(layoutUnit:ILayoutUnits):void
		{
			_fromValues.splice(_fromValues.indexOf(layoutUnit), 1);
		}
		
		/** Remove all layout units are using for calculation to which values need to animate. */
		public function removeAllToValues():void
		{
			_toValues.length = 0;
		}
		
		/** Remove all layout units are using for calculation from which values need to animate. */
		public function removeAllFromValues():void
		{
			_fromValues.length = 0;
		}
	}
}
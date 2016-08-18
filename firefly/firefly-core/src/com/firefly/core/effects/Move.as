package com.firefly.core.effects
{
	import com.firefly.core.Firefly;
	import com.firefly.core.firefly_internal;
	import com.firefly.core.async.Future;
	import com.firefly.core.layouts.constraints.$x;
	import com.firefly.core.layouts.constraints.$y;
	import com.firefly.core.layouts.constraints.ILayoutUnits;
	import com.firefly.core.layouts.constraints.LayoutConstraint;
	import com.firefly.core.layouts.helpers.LayoutContext;
	import com.firefly.core.layouts.helpers.LayoutElement;
	
	import flash.geom.Point;
	
	import starling.animation.Tween;
	
	use namespace firefly_internal;
	
	/** The animation class specially created for animating x/y values of the object on the basis of speed (pixels per second).
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
	 
var animation:Move = new Move(quad, 3, $x(300).cpx, $y(200).cpx);
animation.play();
	 *************************************************************************************
	 *  </listing> 
	 * 
	 * 	@example The following code shows how to use this class to animate the x, y of the object
	 *  using real pixels layout units and move speed value:
	 *  <listing version="3.0">
	 *************************************************************************************
var layout:Layout = new Layout(this);
var quad:Quad = new Quad(100, 100, 0x000000);
layout.addElement(quad, $left(20).cpx, $top(20).cpx, $width(100).cpx, $height(100).cpx);
	 
var animation:Move = new Move(quad, NaN, $x(300).px, $y(200).px);
animation.speed = 500;
animation.play();
	 *************************************************************************************
	 *  </listing> */
	public class Move extends AnimationBase
	{
		/** @private */
		private var _toX:ILayoutUnits;
		/** @private */
		private var _toY:ILayoutUnits;
		/** @private */
		private var _fromX:ILayoutUnits;
		/** @private */
		private var _fromY:ILayoutUnits;
		/** @private */
		private var _layoutContext:LayoutContext;
		/** @private */
		private var _speed:Number;
		/** @private */
		private var _toLayoutElement:LayoutElement;
		/** @private */
		private var _fromLayoutElement:LayoutElement;
		
		/** Constructor.
		 *  @param target Target of the animation.
		 *  @param duration Duration in seconds.
		 *  @param toX Layout units will be used for calculation to which <code>x</code> value need to animate.
		 *  @param toY Layout units will be used for calculation to which <code>y</code> value need to animate.
		 *  @param fromX Layout units will be used for calculation from which <code>x</code> value need to animate.
		 *  @param fromY Layout units will be used for calculation from which <code>y</code> value need to animate.
		 *  @param layoutContext Layout context that be used for layout calculation. */		
		public function Move(target:Object, duration:Number=NaN, toX:ILayoutUnits=null, toY:ILayoutUnits=null, 
							 fromX:ILayoutUnits=null, fromY:ILayoutUnits=null, layoutContext:LayoutContext=null)
		{
			super(target, duration);
			
			_toX = toX;
			_toY = toY;
			_fromX = fromX;
			_fromY = fromY;
			_layoutContext = layoutContext;
			_toLayoutElement = new LayoutElement();
			_fromLayoutElement = new LayoutElement();
		}
		
		/** @inheritDoc */
		override protected function createTween():Tween
		{
			var tween:Tween = super.createTween();
			
			if (_toLayoutElement._xChanged)
				tween.animate("x", _toLayoutElement.x + _toLayoutElement.pivotX);
			if (_toLayoutElement._yChanged)
				tween.animate("y", _toLayoutElement.y + _toLayoutElement.pivotY);
			
			return tween;
		}
		
		/** @inheritDoc  */
		override public function play():Future
		{
			if (!_layoutContext)
				_layoutContext = Firefly.current.layoutContext;
			
			if (_fromX)
				_fromLayoutElement.addConstraint(_fromX as LayoutConstraint);
			if (_fromY)
				_fromLayoutElement.addConstraint(_fromY as LayoutConstraint);
			if (_toX)
				_toLayoutElement.addConstraint(_toX as LayoutConstraint);
			if (_toY)
				_toLayoutElement.addConstraint(_toY as LayoutConstraint);
			
			_fromLayoutElement.layout(_layoutContext, target, null);
			_toLayoutElement.layout(_layoutContext, target, null, false);
			
			if(_toLayoutElement._xChanged && !_fromLayoutElement._xChanged)
				_fromX = $x(target.x).px;
			if(_toLayoutElement._yChanged && !_fromLayoutElement._yChanged)
				_fromY = $y(target.y).px;
			
			if(!isNaN(speed))
			{
				var distX:Number = 0;
				var distY:Number = 0;
				
				if(!isNaN(_toLayoutElement.x))
					distX = _toLayoutElement.x - _fromLayoutElement.x;
				
				if(!isNaN(_toLayoutElement.y))
					distY = _toLayoutElement.y - _fromLayoutElement.y;
				
				duration = new Point(distX, distY).length/speed;
			}
			
			return super.play();
		}
		
		/** Layout context that be used for layout calculation. */
		public function get layoutContext():LayoutContext { return _layoutContext }
		public function set layoutContext(value:LayoutContext):void { _layoutContext = value }
		
		/** Layout units will be used for calculation to which <code>x</code> value need to animate. */
		public function get toX():ILayoutUnits { return _toX }
		public function set toX(value:ILayoutUnits):void { _toX = value }
		
		/** Layout units will be used for calculation to which <code>y</code> value need to animate. */
		public function get toY():ILayoutUnits { return _toY }
		public function set toY(value:ILayoutUnits):void { _toY = value }
		
		/** Layout units will be used for calculation from which <code>x</code> value need to animate. */
		public function get fromX():ILayoutUnits { return _fromX }
		public function set fromX(value:ILayoutUnits):void { _fromX = value }
		
		/** Layout units will be used for calculation from which <code>y</code> value need to animate. */
		public function get fromY():ILayoutUnits { return _fromY }
		public function set fromY(value:ILayoutUnits):void { _fromY = value }
		
		/** Move speed pixels per second. */
		public function get speed():Number { return _speed }
		public function set speed(value:Number):void { _speed = value }
		
		
		/** @inheritDoc */
		override public function end():void
		{
			_toLayoutElement.apply();
			
			super.end();
		}
		
		/** @inheritDoc */
		override public function clear():void
		{
			_fromX = null;
			_fromY = null;
			_toX = null;
			_toY = null;
			
			super.clear();
		}
	}
}
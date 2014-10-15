package com.firefly.core.controllers
{
	import com.firefly.core.consts.TouchType;
	import com.firefly.core.display.IHScrollerContainer;
	import com.firefly.core.display.ITouch;
	import com.firefly.core.effects.Move;
	import com.firefly.core.effects.easing.Power;
	import com.firefly.core.layouts.constraints.$x;
	
	import flash.geom.Rectangle;
	
	public class HScrollerCtrl
	{
		private var _scroller:IHScrollerContainer;
		private var _lastTouch:ITouch;
		private var _move:Move;
		private var _fRect:Rectangle = new Rectangle();
		private var _sRect:Rectangle = new Rectangle();
		private var _scrollPullingEnabled:Boolean;
		
		public function HScrollerCtrl(scroller:IHScrollerContainer)
		{
			_scroller = scroller;
			_move = new Move(null);
			_move.speed = 1000;
			_move.easer = new Power(0.5, 3);
		}
		
		public function get scrollPullingEnabled():Boolean { return _scrollPullingEnabled; }
		public function set scrollPullingEnabled(value:Boolean):void { _scrollPullingEnabled = value; }
		
		public function update(touch:ITouch):void
		{
			if (!_lastTouch)
			{
				_lastTouch = touch.clone();
				return;
			}
			
			var vBounds:Rectangle = _scroller.getViewportBounds();
			var dx:Number = touch.x - _lastTouch.x;
			if (dx != 0 && isAllowScrolling(dx, vBounds))
				_scroller.updateX(dx);
			
			if (touch.phaseType == TouchType.MOVED)
			{
				_lastTouch.x = touch.x;
				_lastTouch.phaseType = touch.phaseType;
			}
			else if (touch.phaseType == TouchType.ENDED)
			{
				_lastTouch = null;
				
				if (_scrollPullingEnabled)
				{
					if (vBounds.x > 0)
						moveToLeft();
					else if (vBounds.x + vBounds.width < _scroller.width)
						moveToRight();
				}
			}
		}
		
		private function isAllowScrolling(dx:Number, vBounds:Rectangle):Boolean
		{
			if (_scrollPullingEnabled)
				return (vBounds.x + dx > _scroller.width) || (vBounds.x + vBounds.width + dx < 0) ? false : true;
			else
				return  (vBounds.x + dx > 0 || vBounds.x + vBounds.width + dx < _scroller.width) ? false : true;
		}
		
		private function moveToLeft():void
		{
			_fRect.x = _sRect.x = _scroller.getViewportBounds().x;
			_move.target = _sRect;
			_move.fromX = $x(_sRect.x);
			_move.toX = $x(0);
			_move.play().progress(animateProgress);
		}
		
		private function moveToRight():void
		{
			var vBounds:Rectangle = _scroller.getViewportBounds();
			_fRect.x = _sRect.x = vBounds.x;
			_move.target = _sRect;
			_move.fromX = $x(vBounds.x);
			_move.toX = $x(_scroller.width - vBounds.width);
			_move.play().progress(animateProgress);
		}
		
		private function animateProgress(progress:Number):void
		{
			_scroller.updateX(_sRect.x - _fRect.x);
			_fRect.x = _sRect.x;
		}
	}
}
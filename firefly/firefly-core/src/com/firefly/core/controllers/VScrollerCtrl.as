package com.firefly.core.controllers
{
	import com.firefly.core.consts.TouchType;
	import com.firefly.core.display.ITouch;
	import com.firefly.core.display.IVScrollerContainer;
	import com.firefly.core.effects.Move;
	import com.firefly.core.effects.easing.Power;
	import com.firefly.core.layouts.constraints.$y;
	
	import flash.geom.Rectangle;

	public class VScrollerCtrl
	{
		private var _scroller:IVScrollerContainer;
		private var _lastTouch:ITouch;
		private var _move:Move;
		private var _fRect:Rectangle = new Rectangle();
		private var _sRect:Rectangle = new Rectangle();
		private var _scrollPullingEnabled:Boolean;
		
		public function VScrollerCtrl(scroller:IVScrollerContainer)
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
			var dy:Number = touch.y - _lastTouch.y;
			if (dy != 0 && isAllowScrolling(dy, vBounds))
				_scroller.updateY(dy);
			
			if (touch.phaseType == TouchType.MOVED)
			{
				_lastTouch.y = touch.y;
				_lastTouch.phaseType = touch.phaseType;
			}
			else if (touch.phaseType == TouchType.ENDED)
			{
				_lastTouch = null;
				
				if (_scrollPullingEnabled)
				{
					if (vBounds.y > 0)
						moveToTop();
					else if (vBounds.y + vBounds.height < _scroller.height)
						moveToBottom();
				}
			}
		}
		
		private function isAllowScrolling(dy:Number, vBounds:Rectangle):Boolean
		{
			if (_scrollPullingEnabled)
				return (vBounds.y + dy > _scroller.height) || (vBounds.y + vBounds.height + dy < 0) ? false : true;
			else
				return  (vBounds.y + dy > 0 || vBounds.y + vBounds.height + dy < _scroller.height) ? false : true;
		}
		
		private function moveToTop():void
		{
			_fRect.y = _sRect.y = _scroller.getViewportBounds().y;
			_move.target = _sRect;
			_move.fromY = $y(_sRect.y);
			_move.toY = $y(0);
			_move.play().progress(animateProgress);
		}
		
		private function moveToBottom():void
		{
			var cBoundingBox:Rectangle = _scroller.getViewportBounds();
			_fRect.y = _sRect.y = cBoundingBox.y;
			_move.target = _sRect;
			_move.fromY = $y(cBoundingBox.y);
			_move.toY = $y(_scroller.height - cBoundingBox.height);
			_move.play().progress(animateProgress);
		}
		
		private function animateProgress(progress:Number):void
		{
			_scroller.updateY(_sRect.y - _fRect.y);
			_fRect.y = _sRect.y;
		}
	}
}
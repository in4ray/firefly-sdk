package com.firefly.core.controllers
{
	import com.firefly.core.cache.Cache;
	import com.firefly.core.consts.TouchType;
	import com.firefly.core.controllers.helpers.TouchData;
	import com.firefly.core.display.IHScrollerContainer;
	import com.firefly.core.display.IViewport;
	import com.firefly.core.effects.Move;
	import com.firefly.core.effects.easing.Power;
	import com.firefly.core.layouts.constraints.$x;
	
	public class HScrollerCtrl
	{
		private var _scroller:IHScrollerContainer;
		private var _lastTouchData:TouchData;
		private var _scrollPullingEnabled:Boolean;
		private var _cache:Cache = new Cache(Move);
		
		public function HScrollerCtrl(scroller:IHScrollerContainer)
		{
			_scroller = scroller;
		}
		
		public function get scrollPullingEnabled():Boolean { return _scrollPullingEnabled; }
		public function set scrollPullingEnabled(value:Boolean):void { _scrollPullingEnabled = value; }
		
		public function update(touchData:TouchData):void
		{
			if (!_lastTouchData)
			{
				_lastTouchData = touchData.clone();
				return;
			}
			
			var dx:Number = touchData.x - _lastTouchData.x;
			
			_scroller.viewports.forEach(function (viewport:IViewport, index:int, args:Vector.<IViewport>):void
			{
				if (dx != 0 && isAllowScrolling(dx * viewport.hFraction, viewport))
					viewport.x += dx * viewport.hFraction;
				
				if (touchData.phaseType == TouchType.END && _scrollPullingEnabled)
				{
					if (viewport.x > 0)
						moveToLeft(viewport);
					else if (viewport.x + viewport.width < _scroller.width)
						moveToRight(viewport);
				}
			});
			
			if (touchData.phaseType == TouchType.MOVE)
			{
				_lastTouchData.x = touchData.x;
				_lastTouchData.phaseType = touchData.phaseType;
			}
			else if (touchData.phaseType == TouchType.END)
			{
				_lastTouchData = null;
			}
		}
		
		private function isAllowScrolling(dx:Number, viewport:IViewport):Boolean
		{
			if (_scrollPullingEnabled)
				return (viewport.x + dx > _scroller.width) || (viewport.x + viewport.width + dx < 0) ? false : true;
			else
				return  (viewport.x + dx > 0 || viewport.x + viewport.width + dx < _scroller.width) ? false : true;
		}
		
		private function moveToLeft(viewport:IViewport):void
		{
			var move:Move = _cache.getItem(null);
			move.speed = 1000;
			move.easer = new Power(0.5, 3);
			move.target = viewport;
			move.fromX = $x(viewport.x);
			move.toX = $x(0);
			move.play().then(moveComplete, move);
		}
		
		private function moveToRight(viewport:IViewport):void
		{
			var move:Move = _cache.getItem(null);
			move.speed = 1000;
			move.easer = new Power(0.5, 3);
			move.target = viewport;
			move.fromX = $x(viewport.x);
			move.toX = $x(_scroller.width - viewport.width);
			move.play().then(moveComplete, move);
		}
		
		private function moveComplete(move:Move):void
		{
			_cache.cache(move);
		}
	}
}
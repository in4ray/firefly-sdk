package com.firefly.core.controllers
{
	import com.firefly.core.cache.Cache;
	import com.firefly.core.consts.TouchType;
	import com.firefly.core.controllers.helpers.TouchData;
	import com.firefly.core.display.IVScrollerContainer;
	import com.firefly.core.display.IViewport;
	import com.firefly.core.effects.Move;
	import com.firefly.core.effects.easing.Power;
	import com.firefly.core.layouts.constraints.$y;

	public class VScrollerCtrl
	{
		private var _scroller:IVScrollerContainer;
		private var _lastTouchData:TouchData;
		private var _scrollPullingEnabled:Boolean;
		private var _cache:Cache = new Cache(Move);
		
		public function VScrollerCtrl(scroller:IVScrollerContainer)
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
			
			var dy:Number = touchData.y - _lastTouchData.y;
			
			_scroller.viewports.forEach(function (viewport:IViewport, index:int, args:Vector.<IViewport>):void
			{
				if (dy != 0 && isAllowScrolling(dy * viewport.moveMultiplier, viewport))
					viewport.y += dy * viewport.moveMultiplier;
				
				if (touchData.phaseType == TouchType.END && _scrollPullingEnabled)
				{
					if (viewport.y > 0)
						moveToTop(viewport);
					else if (viewport.y + viewport.height < _scroller.height)
						moveToBottom(viewport);
				}
			});
			
			if (touchData.phaseType == TouchType.MOVE)
			{
				_lastTouchData.y = touchData.y;
				_lastTouchData.phaseType = touchData.phaseType;
			}
			else if (touchData.phaseType == TouchType.END)
			{
				_lastTouchData = null;
			}
		}
		
		private function isAllowScrolling(dy:Number, viewport:IViewport):Boolean
		{
			if (_scrollPullingEnabled)
				return (viewport.y + dy > _scroller.height) || (viewport.y + viewport.height + dy < 0) ? false : true;
			else
				return  (viewport.y + dy > 0 || viewport.y + viewport.height + dy < _scroller.height) ? false : true;
		}
		
		private function moveToTop(viewport:IViewport):void
		{
			var move:Move = _cache.getItem(null);
			move.speed = 1000;
			move.easer = new Power(0.5, 3);
			move.target = viewport;
			move.fromX = $y(viewport.y);
			move.toX = $y(0);
			move.play().then(moveComplete, move);
		}
		
		private function moveToBottom(viewport:IViewport):void
		{
			var move:Move = _cache.getItem(null);
			move.speed = 1000;
			move.easer = new Power(0.5, 3);
			move.target = viewport;
			move.fromX = $y(viewport.y);
			move.toX = $y(_scroller.height - viewport.height);
			move.play().then(moveComplete, move);
		}
		
		private function moveComplete(move:Move):void
		{
			_cache.cache(move);
		}
	}
}
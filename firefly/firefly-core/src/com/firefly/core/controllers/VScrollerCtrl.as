// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

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

	/** Controller for managing vertical scroller container.
	 * 
	 *  @see com.firefly.core.controllers.VScrollBarCtrl  */
	public class VScrollerCtrl
	{
		/** @private */
		private var _scroller:IVScrollerContainer;
		/** @private */
		private var _scrollBarCtrl:VScrollBarCtrl;
		/** @private */
		private var _scrollPullingEnabled:Boolean;
		/** @private */
		private var _lastTouchData:TouchData;
		/** @private */
		private var _highestViewport:IViewport;
		/** @private */
		private var _maxHeight:int;
		/** @private */
		private var _cache:Cache;
		
		/** Constructor.
		 *  @param scroller Vertical scroller container.
		 *  @param scrollBarCtrl Vertical scroll bar component. */
		public function VScrollerCtrl(scroller:IVScrollerContainer, scrollBarCtrl:VScrollBarCtrl=null)
		{
			_scroller = scroller;
			_scrollBarCtrl = scrollBarCtrl;
			_cache = new Cache(Move)
		}
		
		/** Vertical scroller container. */		
		public function get scroller():IVScrollerContainer { return _scroller; }
		public function set scroller(value:IVScrollerContainer):void { _scroller = value; }
		
		/** Vertical scroll bar component. */	
		public function get scrollBarCtrl():VScrollBarCtrl { return _scrollBarCtrl; }
		public function set scrollBarCtrl(value:VScrollBarCtrl):void { _scrollBarCtrl = value; }
		
		/** Enable pulling effect when user scrolls content inside scroller out of the component. */	
		public function get scrollPullingEnabled():Boolean { return _scrollPullingEnabled; }
		public function set scrollPullingEnabled(value:Boolean):void { _scrollPullingEnabled = value; }

		/** Update scoller and scroll bars based on the touch data.
		 *  @param touchData Touch data. */	
		public function update(touchData:TouchData):void
		{
			if (!_lastTouchData)
			{
				_lastTouchData = touchData.clone();
				return;
			}
			
			var dy:Number = touchData.y - _lastTouchData.y;
			_maxHeight = 0;
			_scroller.viewports.forEach(function (viewport:IViewport, index:int, args:Vector.<IViewport>):void
			{
				var vpHeight:Number = viewport.height;
				if (vpHeight >= _maxHeight)
				{
					_maxHeight = vpHeight;
					_highestViewport = viewport;
				}
				
				if (dy != 0 && canScroll(dy * viewport.vFraction, viewport))
					viewport.y += dy * viewport.vFraction;
				
				if (touchData.phase == TouchType.ENDED && _scrollPullingEnabled)
				{
					if (viewport.y > 0)
						moveToTop(viewport);
					else if (viewport.y + viewport.height < _scroller.height)
						moveToBottom(viewport);
				}
			});
			
			if (_scrollBarCtrl)
				_scrollBarCtrl.updateThumb(_highestViewport.y / (_scroller.height - _maxHeight));
			
			if (touchData.phase == TouchType.MOVED)
			{
				_lastTouchData.y = touchData.y;
				_lastTouchData.phase = touchData.phase;
			}
			else if (touchData.phase == TouchType.ENDED)
			{
				_lastTouchData = null;
			}
		}
		
		private function canScroll(dy:Number, viewport:IViewport):Boolean
		{
			if (_scrollPullingEnabled)
				return (viewport.y + dy > _scroller.height) || (viewport.y + viewport.height + dy < 0) ? false : true;
			else
				return  (viewport.y + dy > 0 || viewport.y + viewport.height + dy < _scroller.height) ? false : true;
		}
		
		/** @private */
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
		
		/** @private */
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
		
		/** @private */
		private function moveComplete(move:Move):void
		{
			_cache.cache(move);
		}
	}
}
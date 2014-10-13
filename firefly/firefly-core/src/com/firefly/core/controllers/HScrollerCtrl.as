package com.firefly.core.controllers
{
	import com.firefly.core.consts.ContactPhase;
	import com.firefly.core.controllers.helpers.ContactPoint;
	import com.firefly.core.display.IHScrollerContainer;
	import com.firefly.core.effects.Move;
	import com.firefly.core.effects.easing.Power;
	import com.firefly.core.layouts.constraints.$x;
	
	import flash.geom.Rectangle;
	
	public class HScrollerCtrl
	{
		private var _scroller:IHScrollerContainer;
		private var _lastContact:ContactPoint;
		private var _move:Move;
		private var _fRect:Rectangle = new Rectangle();
		private var _sRect:Rectangle = new Rectangle();
		
		public function HScrollerCtrl(scroller:IHScrollerContainer)
		{
			_scroller = scroller;
			_move = new Move(null);
			_move.speed = 1000;
			_move.easer = new Power(0.5, 3);
		}
		
		public function contactChanged(contact:ContactPoint):void
		{
			if (!_lastContact)
			{
				_lastContact = contact;
				return;
			}
			
			var boundingBox:Rectangle = _scroller.getContentBoundingBox();
			var dx:Number = contact.x - _lastContact.x;
			var isLeftOutside:Boolean = boundingBox.x + boundingBox.width + dx < 0;
			var isRightOutside:Boolean = boundingBox.x + dx > _scroller.width;
			if (isLeftOutside || isRightOutside)
				dx = 0;
			
			_scroller.updateX(dx);
			
			if (contact.phase == ContactPhase.MOVED)
			{
				_lastContact = contact;
			}
			else if (contact.phase == ContactPhase.ENDED)
			{
				_lastContact = null;
				if (isLeftOutside)
					animateToRightSide();
				else if (isRightOutside)
					animateToLeftSide();
			}
		}
		
		private function animateToLeftSide():void
		{
			_fRect.x = _sRect.x = _scroller.getContentBoundingBox().x;
			_move.target = _sRect;
			_move.fromX = $x(_sRect.x);
			_move.toX = $x(0);
			_move.play().progress(animateProgress);
		}
		
		private function animateToRightSide():void
		{
			var boundingBox:Rectangle = _scroller.getContentBoundingBox();
			_fRect.x = _sRect.x = boundingBox.x + boundingBox.width + _scroller.width;
			_move.target = _sRect;
			_move.fromX = $x(boundingBox.x);
			_move.toX = $x(_sRect.x);
			_move.play().progress(animateProgress);
		}
		
		private function animateProgress(progress:Number):void
		{
			_scroller.updateX(_sRect.x - _fRect.x);
			_fRect.x = _sRect.x;
		}
	}
}
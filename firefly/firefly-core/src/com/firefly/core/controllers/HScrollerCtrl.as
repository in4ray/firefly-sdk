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
			
			var cBoundingBox:Rectangle = _scroller.getViewportBounds();
			var dx:Number = contact.x - _lastContact.x;
			dx = (cBoundingBox.x + dx > _scroller.width) || (cBoundingBox.x + cBoundingBox.width + dx < 0) ? 0 : dx;
			
			if (contact.phase == ContactPhase.MOVED)
			{
				_scroller.updateX(dx);
				_lastContact = contact;
			}
			else if (contact.phase == ContactPhase.ENDED)
			{
				if (cBoundingBox.x > 0)
					moveToLeft();
				else if (cBoundingBox.x + cBoundingBox.width < _scroller.width)
					moveToRight();
				
				_lastContact = null;
			}
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
			var cBoundingBox:Rectangle = _scroller.getViewportBounds();
			_fRect.x = _sRect.x = cBoundingBox.x;
			_move.target = _sRect;
			_move.fromX = $x(cBoundingBox.x);
			_move.toX = $x(_scroller.width - cBoundingBox.width);
			_move.play().progress(animateProgress);
		}
		
		private function animateProgress(progress:Number):void
		{
			_scroller.updateX(_sRect.x - _fRect.x);
			_fRect.x = _sRect.x;
		}
	}
}
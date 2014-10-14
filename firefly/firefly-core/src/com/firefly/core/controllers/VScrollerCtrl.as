package com.firefly.core.controllers
{
	import com.firefly.core.consts.ContactPhase;
	import com.firefly.core.controllers.helpers.ContactPoint;
	import com.firefly.core.display.IVScrollerContainer;
	import com.firefly.core.effects.Move;
	import com.firefly.core.effects.easing.Power;
	import com.firefly.core.layouts.constraints.$x;
	import com.firefly.core.layouts.constraints.$y;
	
	import flash.geom.Rectangle;

	public class VScrollerCtrl
	{
		private var _scroller:IVScrollerContainer;
		private var _lastContact:ContactPoint;
		private var _move:Move;
		private var _fRect:Rectangle = new Rectangle();
		private var _sRect:Rectangle = new Rectangle();
		
		public function VScrollerCtrl(scroller:IVScrollerContainer)
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
			var dy:Number = contact.y - _lastContact.y;
			dy = (cBoundingBox.y + dy > _scroller.height) || (cBoundingBox.y + cBoundingBox.height + dy < 0) ? 0 : dy;
			
			if (contact.phase == ContactPhase.MOVED)
			{
				_scroller.updateY(dy);
				_lastContact = contact;
			}
			else if (contact.phase == ContactPhase.ENDED)
			{
				if (cBoundingBox.y > 0)
					moveToTop();
				else if (cBoundingBox.y + cBoundingBox.height < _scroller.height)
					moveToBottom();
				
				_lastContact = null;
			}
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
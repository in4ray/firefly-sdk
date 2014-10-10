package com.firefly.core.controllers
{
	import com.firefly.core.consts.ContactPhase;
	import com.firefly.core.controllers.helpers.ContactPoint;
	import com.firefly.core.display.IHScrollerContainer;
	
	public class HScrollerCtrl
	{
		private var _scroller:IHScrollerContainer;
		private var _lastContact:ContactPoint;
		
		public function HScrollerCtrl(scroller:IHScrollerContainer)
		{
			_scroller = scroller;
		}
		
		public function contactChanged(contact:ContactPoint):void
		{
			if (!_lastContact)
			{
				_lastContact = contact;
			}
			else if (contact.phase == ContactPhase.MOVED)
			{
				_scroller.updateX(contact.x - _lastContact.x);
				_lastContact = contact;
			}
			else if (contact.phase == ContactPhase.ENDED)
			{
				_scroller.updateX(contact.x - _lastContact.x);
				_lastContact = null;
			}
		}
	}
}
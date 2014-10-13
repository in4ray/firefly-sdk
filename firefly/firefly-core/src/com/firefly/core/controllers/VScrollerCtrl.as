package com.firefly.core.controllers
{
	import com.firefly.core.consts.ContactPhase;
	import com.firefly.core.controllers.helpers.ContactPoint;
	import com.firefly.core.display.IVScrollerContainer;

	public class VScrollerCtrl
	{
		private var _scroller:IVScrollerContainer;
		private var _lastContact:ContactPoint;
		
		public function VScrollerCtrl(scroller:IVScrollerContainer)
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
				_scroller.updateY(contact.y - _lastContact.y);
				_lastContact = contact;
			}
			else if (contact.phase == ContactPhase.ENDED)
			{
				_scroller.updateY(contact.y - _lastContact.y);
				_lastContact = null;
			}
		}
	}
}
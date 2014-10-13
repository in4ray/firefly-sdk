package com.firefly.core.components
{
	import com.firefly.core.consts.ContactPhase;
	import com.firefly.core.controllers.HScrollerCtrl;
	import com.firefly.core.controllers.VScrollerCtrl;
	import com.firefly.core.controllers.helpers.ContactPoint;
	import com.firefly.core.display.IHScrollerContainer;
	import com.firefly.core.display.IVScrollerContainer;
	
	import flash.geom.Rectangle;
	
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class ScrollerContainer extends Container implements IVScrollerContainer, IHScrollerContainer
	{
		private var _container:Container;
		private var _contentBoundingBox:Rectangle;
		private var _hScrollerCtrl:HScrollerCtrl;
		private var _vScrollerCtrl:VScrollerCtrl;
		
		public function ScrollerContainer()
		{
			super();
			
			_container = new Container();
			_hScrollerCtrl = new HScrollerCtrl(this);
			_vScrollerCtrl = new VScrollerCtrl(this);
			
			layout.addElement(_container);
			clipRect = new Rectangle(0, 0, width, height);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		public function get hScrollerCtrl():HScrollerCtrl { return _hScrollerCtrl; }
		public function get vScrollerCtrl():VScrollerCtrl { return _vScrollerCtrl; }
		
		override public function set width(value:Number):void
		{
			super.width = clipRect.width = value;
		}
		
		override public function set height(value:Number):void
		{
			super.height = clipRect.height = value;
		}
		
		public function addElement(child:Object, ...layouts):void
		{
			_container.layout.addElement.apply(null, [child].concat(layouts));
		}
		
		public function addElementAt(child:Object, index:int, ...layouts):void
		{
			_container.layout.addElementAt.apply(null, [child, index].concat(layouts));
		}
		
		public function removeElement(child:Object):void
		{
			_container.layout.removeElement(child);
		}
		
		public function removeElementAt(index:int):void
		{
			_container.layout.removeElementAt(index);
		}
		
		public function updateX(dx:Number):void
		{
			_container.x += dx;
		}
		
		public function updateY(dy:Number):void
		{
			_container.y += dy;
		}
		
		public function getContentBoundingBox():Rectangle
		{
			if (!_contentBoundingBox)
				_contentBoundingBox = new Rectangle();
			
			_contentBoundingBox.x = _container.x;
			_contentBoundingBox.y = _container.y;
			_contentBoundingBox.width = _container.width;
			_contentBoundingBox.height = _container.height;
			
			return _contentBoundingBox;
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var contactPoint:ContactPoint;
			var bTouch:Touch = e.getTouch(this, TouchPhase.BEGAN);
			var mTouch:Touch = e.getTouch(this, TouchPhase.MOVED);
			var eTouch:Touch = e.getTouch(this, TouchPhase.ENDED);
			if (bTouch)
				contactPoint = new ContactPoint(bTouch.globalX, bTouch.globalY, ContactPhase.BEGAN);
			else if (mTouch)
				contactPoint = new ContactPoint(mTouch.globalX, mTouch.globalY, ContactPhase.MOVED);
			else if (eTouch)
				contactPoint = new ContactPoint(eTouch.globalX, eTouch.globalY, ContactPhase.ENDED);
			
			if (contactPoint)
			{
				_hScrollerCtrl.contactChanged(contactPoint);
				_vScrollerCtrl.contactChanged(contactPoint);
			}
		}
	}
}
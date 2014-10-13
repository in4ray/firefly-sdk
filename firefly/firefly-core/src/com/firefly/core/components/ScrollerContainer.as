package com.firefly.core.components
{
	import com.firefly.core.consts.ContactPhase;
	import com.firefly.core.controllers.HScrollerCtrl;
	import com.firefly.core.controllers.VScrollerCtrl;
	import com.firefly.core.controllers.helpers.ContactPoint;
	import com.firefly.core.display.IHScrollerContainer;
	import com.firefly.core.display.IVScrollerContainer;
	import com.firefly.core.layouts.constraints.$x;
	import com.firefly.core.layouts.constraints.$y;
	
	import flash.geom.Rectangle;
	
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class ScrollerContainer extends Container implements IVScrollerContainer, IHScrollerContainer
	{
		private var _container:Container;
		private var _hScrollerCtrl:HScrollerCtrl;
		private var _vScrollerCtrl:VScrollerCtrl;
		private var _minX:Number = 0;
		private var _minY:Number = 0;
		private var _maxX:Number;
		private var _maxY:Number;
		
		public function ScrollerContainer()
		{
			super();
			
			_container = new Container();
			_hScrollerCtrl = new HScrollerCtrl(this);
			_vScrollerCtrl = new VScrollerCtrl(this);
			
			layout.addElement(_container, $x(0), $y(0));
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		override public function set height(value:Number):void
		{
			super.height = value;
			
			clipRect = new Rectangle(0, 0, width, height);
		}
		
		override public function set width(value:Number):void
		{
			super.width = value;
			
			clipRect = new Rectangle(0, 0, width, height);
		}
		
		public function get hScrollerCtrl():HScrollerCtrl { return _hScrollerCtrl; }
		public function get vScrollerCtrl():VScrollerCtrl { return _vScrollerCtrl; }
		
		public function addElement(child:Object, ...layouts):void
		{
			_container.layout.addElement.apply(null, [child].concat(layouts));
			updateViewPort();
		}
		
		public function addElementAt(child:Object, index:int, ...layouts):void
		{
			_container.layout.addElementAt.apply(null, [child, index].concat(layouts));
			updateViewPort();
		}
		
		public function removeElement(child:Object):void
		{
			_container.layout.removeElement(child);
			updateViewPort();
		}
		
		public function removeElementAt(index:int):void
		{
			_container.layout.removeElementAt(index);
			updateViewPort();
		}
		
		public function updateX(dx:Number):void
		{
			var newX:Number = _container.x + dx;
			/*var minX:Number = _container.x - _container.width;
			if (newX < _container.x - _container.width)*/
			
			_container.x += dx;
			
			trace("x=" + _container.x + ", y=" + _container.y);
		}
		
		public function updateY(dy:Number):void
		{
			_container.y += dy;
		}
		
		private function updateViewPort():void
		{
			/*_minX = -_container.width;
			_minY = -_container.height;
			_maxX = _container.width
			_maxY = _container.height;*/
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			updateViewPort();
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
				trace(contactPoint.x + ", " + contactPoint.y + ", " + contactPoint.phase);
				_hScrollerCtrl.contactChanged(contactPoint);
				_vScrollerCtrl.contactChanged(contactPoint);
			}
		}
	}
}
package com.firefly.core.components
{
	import com.firefly.core.controllers.HScrollerCtrl;
	import com.firefly.core.controllers.VScrollerCtrl;
	import com.firefly.core.controllers.helpers.TouchProxy;
	import com.firefly.core.display.IHScrollerContainer;
	import com.firefly.core.display.IVScrollerContainer;
	
	import flash.geom.Rectangle;
	
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class ScrollerContainer extends Container implements IVScrollerContainer, IHScrollerContainer
	{
		private var _viewport:Container;
		private var _viewportBounds:Rectangle;
		private var _hScrollerCtrl:HScrollerCtrl;
		private var _vScrollerCtrl:VScrollerCtrl;
		private var _touchProxy:TouchProxy;
		
		public function ScrollerContainer()
		{
			super();
			
			_viewport = new Container();
			_hScrollerCtrl = new HScrollerCtrl(this);
			_vScrollerCtrl = new VScrollerCtrl(this);
			
			layout.addElement(_viewport);
			clipRect = new Rectangle(0, 0, width, height);
			
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
			_viewport.layout.addElement.apply(null, [child].concat(layouts));
		}
		
		public function addElementAt(child:Object, index:int, ...layouts):void
		{
			_viewport.layout.addElementAt.apply(null, [child, index].concat(layouts));
		}
		
		public function removeElement(child:Object):void
		{
			_viewport.layout.removeElement(child);
		}
		
		public function removeElementAt(index:int):void
		{
			_viewport.layout.removeElementAt(index);
		}
		
		public function updateX(dx:Number):void
		{
			_viewport.x += dx;
		}
		
		public function updateY(dy:Number):void
		{
			_viewport.y += dy;
		}
		
		public function getViewportBounds():Rectangle
		{
			if (!_viewportBounds)
				_viewportBounds = new Rectangle();
			
			_viewportBounds.x = _viewport.x;
			_viewportBounds.y = _viewport.y;
			_viewportBounds.width = _viewport.width;
			_viewportBounds.height = _viewport.height;
			
			return _viewportBounds;
		}
		
		private function onTouch(e:TouchEvent):void
		{
			if (!_touchProxy)
				_touchProxy = new TouchProxy();
			
			_touchProxy.touch = e.getTouch(this, TouchPhase.BEGAN);
			if (!_touchProxy.touch)
				_touchProxy.touch = e.getTouch(this, TouchPhase.MOVED);
			if (!_touchProxy.touch)
				_touchProxy.touch = e.getTouch(this, TouchPhase.ENDED);
			
			if (_touchProxy.touch)
			{
				_hScrollerCtrl.update(_touchProxy);
				_vScrollerCtrl.update(_touchProxy);
			}
		}
	}
}
package com.firefly.core.components
{
	import com.firefly.core.controllers.HScrollerCtrl;
	import com.firefly.core.controllers.VScrollerCtrl;
	import com.firefly.core.display.IHScrollerContainer;
	import com.firefly.core.display.IVScrollerContainer;
	
	import flash.geom.Rectangle;
	
	import starling.events.Event;
	
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
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function get hScrollerCtrl():HScrollerCtrl { return _hScrollerCtrl; }
		public function get vScrollerCtrl():VScrollerCtrl { return _vScrollerCtrl; }
		
		public function addElement(child:Object, ...layouts):void
		{
			_container.layout.addElement(child, layouts);
			updateScrollingArea();
		}
		
		public function addElementAt(child:Object, index:int, ...layouts):void
		{
			_container.layout.addElementAt(child, index, layouts);
			updateScrollingArea();
		}
		
		public function removeElement(child:Object):void
		{
			_container.layout.removeElement(child);
			updateScrollingArea();
		}
		
		public function removeElementAt(index:int):void
		{
			_container.layout.removeElementAt(index);
			updateScrollingArea();
		}
		
		public function updateX(dx:Number):void
		{
			var newX:Number = _container.x + dx;
			/*var minX:Number = _container.x - _container.width;
			if (newX < _container.x - _container.width)*/
			
			_container.x += dx;
		}
		
		public function updateY(dy:Number):void
		{
			_container.y += dy;
		}
		
		private function updateScrollingArea():void
		{
			/*_minX = -_container.width;
			_minY = -_container.height;
			_maxX = _container.width
			_maxY = _container.height;*/
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			updateScrollingArea();
		}
	}
}
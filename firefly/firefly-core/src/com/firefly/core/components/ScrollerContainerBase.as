package com.firefly.core.components
{
	import com.firefly.core.consts.TouchType;
	import com.firefly.core.controllers.HScrollerCtrl;
	import com.firefly.core.controllers.VScrollerCtrl;
	import com.firefly.core.controllers.helpers.TouchData;
	import com.firefly.core.display.IHScrollerContainer;
	import com.firefly.core.display.IVScrollerContainer;
	import com.firefly.core.display.IViewport;
	
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class ScrollerContainerBase extends Container implements IVScrollerContainer, IHScrollerContainer
	{
		private var _viewports:Vector.<IViewport> = new Vector.<IViewport>();
		private var _hScrollerCtrl:HScrollerCtrl;
		private var _vScrollerCtrl:VScrollerCtrl;
		private var _touchData:TouchData;
		private var _touchTypeMap:Dictionary
		private var _hScrollEnabled:Boolean = true;
		private var _vScrollEnabled:Boolean = true;
		
		public function ScrollerContainerBase()
		{
			super();
			
			_touchTypeMap = new Dictionary();
			_touchTypeMap[TouchPhase.BEGAN] = TouchType.BEGIN;
			_touchTypeMap[TouchPhase.MOVED] = TouchType.MOVE;
			_touchTypeMap[TouchPhase.ENDED] = TouchType.END;
			
			_hScrollerCtrl = new HScrollerCtrl(this);
			_vScrollerCtrl = new VScrollerCtrl(this);
			
			clipRect = new Rectangle(0, 0, width, height);
			
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		public function get viewports():Vector.<IViewport> { return _viewports; }
		public function get hScrollerCtrl():HScrollerCtrl { return _hScrollerCtrl; }
		public function get vScrollerCtrl():VScrollerCtrl { return _vScrollerCtrl; }
		
		public function get vScrollEnabled():Boolean { return _vScrollEnabled; }
		public function set vScrollEnabled(value:Boolean):void { _vScrollEnabled = value; }
		
		public function get hScrollEnabled():Boolean { return _hScrollEnabled; }
		public function set hScrollEnabled(value:Boolean):void { _hScrollEnabled = value; }
		
		override public function set width(value:Number):void
		{
			super.width = clipRect.width = value;
		}
		
		override public function set height(value:Number):void
		{
			super.height = clipRect.height = value;
		}
		
		override public function dispose():void
		{
			removeEventListener(TouchEvent.TOUCH, onTouch);
			
			super.dispose();
		}
		
		private function onTouch(e:TouchEvent):void
		{
			if (!_touchData)
				_touchData = new TouchData();
			
			var touch:Touch = e.getTouch(this, TouchPhase.BEGAN);
			if (!touch)
				touch = e.getTouch(this, TouchPhase.MOVED);
			if (!touch)
				touch = e.getTouch(this, TouchPhase.ENDED);
			
			if (touch)
			{
				_touchData.x = touch.globalX;
				_touchData.y = touch.globalY;
				_touchData.phaseType = _touchTypeMap[touch.phase];
				
				if (_hScrollEnabled)
					_hScrollerCtrl.update(_touchData);
				if (_vScrollEnabled)
					_vScrollerCtrl.update(_touchData);
			}
		}
	}
}
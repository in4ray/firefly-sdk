package com.firefly.core.components
{
	import com.firefly.core.controllers.HScrollBarCtrl;
	import com.firefly.core.controllers.HScrollerCtrl;
	import com.firefly.core.controllers.VScrollBarCtrl;
	import com.firefly.core.controllers.VScrollerCtrl;
	import com.firefly.core.controllers.helpers.TouchData;
	import com.firefly.core.display.IHScrollBar;
	import com.firefly.core.display.IHScrollerContainer;
	import com.firefly.core.display.IVScrollBar;
	import com.firefly.core.display.IVScrollerContainer;
	import com.firefly.core.display.IViewport;
	import com.firefly.core.layouts.constraints.$height;
	import com.firefly.core.layouts.constraints.$width;
	import com.firefly.core.layouts.constraints.$x;
	import com.firefly.core.layouts.constraints.$y;
	
	import flash.geom.Rectangle;
	
	import starling.display.DisplayObject;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	public class ScrollerContainerBase extends Component implements IVScrollerContainer, IHScrollerContainer
	{
		private var _hScrollerCtrl:HScrollerCtrl;
		private var _vScrollerCtrl:VScrollerCtrl;
		private var _hScrollerBarCtrl:HScrollBarCtrl;
		private var _vScrollerBarCtrl:VScrollBarCtrl;
		private var _hScrollBar:IHScrollBar;
		private var _vScrollBar:IVScrollBar;
		private var _touchData:TouchData;
		private var _helperRect:Rectangle;
		private var _hScrollEnabled:Boolean = true;
		private var _vScrollEnabled:Boolean = true;
		private var _viewports:Vector.<IViewport> = new Vector.<IViewport>();
		
		public function ScrollerContainerBase(hThumbTexture:Texture=null, vThumbTexture:Texture=null)
		{
			super();
			
			if (hThumbTexture)
			{
				_hScrollBar = new DefaultHScrollBar(hThumbTexture);
				_hScrollerBarCtrl = new HScrollBarCtrl(_hScrollBar);
				layout.addElement(_hScrollBar, $x(0), $width(width), $y(height - _hScrollBar.height));
			}
			
			if (vThumbTexture)
			{
				_vScrollBar = new DefaultVScrollBar(vThumbTexture);
				_vScrollerBarCtrl = new VScrollBarCtrl(_vScrollBar);
				layout.addElement(_vScrollBar, $y(0), $height(height), $x(width - (_hScrollBar ? _hScrollBar.width : 0)));
			}
			
			_hScrollerCtrl = new HScrollerCtrl(this, _hScrollerBarCtrl);
			_vScrollerCtrl = new VScrollerCtrl(this, _vScrollerBarCtrl);
			
			clipRect = new Rectangle(0, 0, width, height);
			
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		override public function set width(value:Number):void 
		{ 
			super.width = clipRect.width = value; 
			
			if (_hScrollBar)
				layout.layoutElement(_hScrollBar, $x(0), $width(value));
			if (_vScrollBar)
				layout.layoutElement(_vScrollBar, $x(value - _vScrollBar.width));
		}
		
		override public function set height(value:Number):void
		{
			super.height = clipRect.height = value;
			
			if (_hScrollBar)
				layout.layoutElement(_hScrollBar, $y(value - _hScrollBar.height));
			if (_vScrollBar)
				layout.layoutElement(_vScrollBar, $y(0), $height(value));
		}
		
		public function get viewports():Vector.<IViewport> { return _viewports; }
		public function get hScrollBar():IHScrollBar { return _hScrollBar; }
		public function get vScrollBar():IVScrollBar { return _vScrollBar; }
		
		public function get hScrollPullingEnabled():Boolean { return _hScrollerCtrl.scrollPullingEnabled; }
		public function set hScrollPullingEnabled(value:Boolean):void { _hScrollerCtrl.scrollPullingEnabled = value; }
		
		public function get vScrollPullingEnabled():Boolean { return _vScrollerCtrl.scrollPullingEnabled; }
		public function set vScrollPullingEnabled(value:Boolean):void { _vScrollerCtrl.scrollPullingEnabled = value; }
		
		public function get hScrollEnabled():Boolean { return _hScrollEnabled; }
		public function set hScrollEnabled(value:Boolean):void
		{
			_hScrollEnabled = value;
			
			if (_hScrollBar)
				_hScrollBar.visible = _hScrollEnabled;
		}
		
		public function get vScrollEnabled():Boolean { return _vScrollEnabled; }
		public function set vScrollEnabled(value:Boolean):void
		{ 
			_vScrollEnabled = value;
			
			if (_vScrollBar)
				_vScrollBar.visible = _vScrollEnabled;
		}
		
		override public function dispose():void
		{
			removeEventListener(TouchEvent.TOUCH, onTouch);
			
			super.dispose();
		}
		
		public function setHSrollBar(scrollBar:IHScrollBar, ...layouts):void
		{
			if (_hScrollBar)
				layout.removeElement(_hScrollBar);
			
			_hScrollBar = scrollBar;
			
			if (!_hScrollerBarCtrl)
				_hScrollerBarCtrl = new HScrollBarCtrl(_hScrollBar);
			else
				_hScrollerBarCtrl.scrollBar = _hScrollBar;
			
			_hScrollerCtrl.scrollBarCtrl = _hScrollerBarCtrl;	
			layout.addElement.apply(null, [_hScrollBar].concat(layouts));
		}
		
		public function setVSrollBar(scrollBar:IVScrollBar, ...layouts):void
		{
			if (_vScrollBar)
				layout.removeElement(_vScrollBar);
			
			_vScrollBar = scrollBar;
			
			if (!_vScrollerBarCtrl)
				_vScrollerBarCtrl = new VScrollBarCtrl(_vScrollBar);
			else
				_vScrollerBarCtrl.scrollBar = _vScrollBar;
			
			_vScrollerCtrl.scrollBarCtrl = _vScrollerBarCtrl;	
			layout.addElement.apply(null, [_vScrollBar].concat(layouts));
		}
		
		protected function layoutScrollBars():void
		{
			if (hScrollBar && getChildIndex(hScrollBar as DisplayObject) != -1)
				setChildIndex(hScrollBar as DisplayObject, numChildren - 1);
			if (vScrollBar && getChildIndex(vScrollBar as DisplayObject) != -1)
				setChildIndex(vScrollBar as DisplayObject, numChildren - 1);
		}
		
		private function onTouch(e:TouchEvent):void
		{
			if (!_touchData)
				_touchData = new TouchData();
			
			var touch:Touch = e.getTouch(this);
			if (touch && touch.phase != TouchPhase.HOVER && touch.phase != TouchPhase.STATIONARY)
			{
				_touchData.x = touch.globalX;
				_touchData.y = touch.globalY;
				_touchData.phase = touch.phase;
				
				if (_hScrollEnabled)
					_hScrollerCtrl.update(_touchData);
				if (_vScrollEnabled)
					_vScrollerCtrl.update(_touchData);
			}
		}
	}
}
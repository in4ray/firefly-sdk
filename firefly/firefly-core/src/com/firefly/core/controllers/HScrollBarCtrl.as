package com.firefly.core.controllers
{
	import com.firefly.core.display.IHScrollBar;

	public class HScrollBarCtrl
	{
		private var _scrollBar:IHScrollBar;
		
		public function HScrollBarCtrl(scrollBar:IHScrollBar)
		{
			_scrollBar = scrollBar;
		}
		
		public function get scrollBar():IHScrollBar { return _scrollBar; }
		public function set scrollBar(value:IHScrollBar):void { _scrollBar = value; }
		
		public function updateThumb(position:Number):void
		{
			if (position >= 0 && position <= 1)
				_scrollBar.thumbX = position * _scrollBar.width - _scrollBar.thumbWidth * position; 
		}
	}
}
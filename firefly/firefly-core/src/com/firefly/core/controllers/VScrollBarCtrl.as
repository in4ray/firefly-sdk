package com.firefly.core.controllers
{
	import com.firefly.core.display.IVScrollBar;

	public class VScrollBarCtrl
	{
		private var _scrollBar:IVScrollBar;
		
		public function VScrollBarCtrl(scrollBar:IVScrollBar)
		{
			_scrollBar = scrollBar;
		}
		
		public function get scrollBar():IVScrollBar { return _scrollBar; }
		public function set scrollBar(value:IVScrollBar):void { _scrollBar = value; }
		
		public function updateThumb(position:Number):void
		{
			if (position >= 0 && position <= 1)
				_scrollBar.thumbY = position * _scrollBar.height - _scrollBar.thumbHeight * position; 
		}
	}
}
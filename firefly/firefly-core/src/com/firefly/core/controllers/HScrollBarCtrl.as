// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.controllers
{
	import com.firefly.core.display.IHScrollBar;

	/** Controller for managing horizontal scrollbaar component which is 
	 *  located in the scroller component. */	
	public class HScrollBarCtrl
	{
		/** @private */
		private var _scrollBar:IHScrollBar;
		
		/** Constructor.
		 *  @param scrollBar Instance of the scrollbar component. */		
		public function HScrollBarCtrl(scrollBar:IHScrollBar)
		{
			_scrollBar = scrollBar;
		}
		
		/** Scrollbar component. */		
		public function get scrollBar():IHScrollBar { return _scrollBar; }
		public function set scrollBar(value:IHScrollBar):void { _scrollBar = value; }
		
		/** Function update position of thumb in the scrollbar component.
		 *  @param position Horizontal position of the thumb. */		
		public function updateThumb(position:Number):void
		{
			if (position >= 0 && position <= 1)
				_scrollBar.thumbX = position * _scrollBar.width - _scrollBar.thumbWidth * position; 
		}
	}
}
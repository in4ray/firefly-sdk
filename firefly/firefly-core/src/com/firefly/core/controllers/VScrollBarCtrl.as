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
	import com.firefly.core.display.IVScrollBar;

	/** Controller for managing vertical scrollbaar component which is 
	 *  located in the scroller component. */
	public class VScrollBarCtrl
	{
		/** @private */
		private var _scrollBar:IVScrollBar;
		
		/** Constructor.
		 *  @param scrollBar Instance of the scrollbar component. */
		public function VScrollBarCtrl(scrollBar:IVScrollBar)
		{
			_scrollBar = scrollBar;
		}
		
		/** Scrollbar component. */	
		public function get scrollBar():IVScrollBar { return _scrollBar; }
		public function set scrollBar(value:IVScrollBar):void { _scrollBar = value; }
		
		/** Function update position of thumb in the scrollbar component.
		 *  @param position Horizontal position of the thumb. */
		public function updateThumb(position:Number):void
		{
			if (position >= 0 && position <= 1)
				_scrollBar.thumbY = position * _scrollBar.height - _scrollBar.thumbHeight * position; 
		}
	}
}
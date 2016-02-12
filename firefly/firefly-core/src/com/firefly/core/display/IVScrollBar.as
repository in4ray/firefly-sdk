// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.display
{
	/** Interface which implemented by vertical scrollbar component for using in scroller component. */
	public interface IVScrollBar
	{
		/** The width of the scrollbar in pixels. */
		function get width():Number;
		
		/** The height of the scrollbar in pixels. */
		function get height():Number;
		
		/** The height of the thumb in pixels. */
		function get thumbHeight():Number;
		
		/** The y position of the thumb in pixels. */
		function set thumbY(value:Number):void;
		
		/** The visibility of the object. */		
		function set visible(value:Boolean):void;
	}
}
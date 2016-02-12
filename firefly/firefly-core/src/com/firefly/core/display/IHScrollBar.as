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
	/** Interface which implemented by horizontal scrollbar component for using in scroller component. */
	public interface IHScrollBar
	{
		/** The width of the scrollbar in pixels. */
		function get width():Number;
		
		/** The height of the scrollbar in pixels. */
		function get height():Number;
		
		/** The width of the thumb in pixels. */
		function get thumbWidth():Number;
		
		/** The x position of the thumb in pixels. */
		function set thumbX(value:Number):void;
		
		/** The visibility of the object. */		
		function set visible(value:Boolean):void;
	}
}
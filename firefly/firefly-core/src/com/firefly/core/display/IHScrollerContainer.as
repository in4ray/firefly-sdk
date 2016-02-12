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
	/** Interface which implemented by horizontal scroller container. */
	public interface IHScrollerContainer
	{
		/** The x coordinate of the scroller container. */
		function get x():Number;
		
		/** The width of the scroller in pixels. */
		function get width():Number;
		
		/** The list of viewport added to the scroller container. */
		function get viewports():Vector.<IViewport>;
	}
}
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
	/** Interface which implemented by vertical scroller container. */
	public interface IVScrollerContainer
	{
		/** The y coordinate of the scroller container. */
		function get y():Number;
		
		/** The height of the scroller in pixels. */
		function get height():Number;
		
		/** The list of viewport added to the scroller container. */
		function get viewports():Vector.<IViewport>;
	}
}
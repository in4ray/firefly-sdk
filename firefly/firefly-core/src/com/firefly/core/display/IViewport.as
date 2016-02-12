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
	/** Interface which implemented by viewport component for using in scroller component. */
	public interface IViewport extends ILayoutComponent
	{
		/** The x coordinate of the object relative to the local coordinates of the parent. */
		function get x():Number;
		function set x(value:Number):void;
		
		/** The y coordinate of the object relative to the local coordinates of the parent. */
		function get y():Number;
		function set y(value:Number):void;
		
		/** The width of the viewport in pixels. */		
		function get width():Number;
		function set width(value:Number):void;
		
		/** The height of the viewport in pixels. */		
		function get height():Number;
		function set height(value:Number):void;
		
		/** Horizontal fraction is used by scroller to move viewport in horizontal axis. */
		function get hFraction():Number;
		function set hFraction(value:Number):void;
		
		/** Vertical fraction is used by scroller to move viewport in vertical axis. */
		function get vFraction():Number;
		function set vFraction(value:Number):void;
	}
}
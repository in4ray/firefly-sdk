// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.components
{
	import com.firefly.core.display.IViewport;
	
	/** The Viewport is component which uses by scrollbar components to display children's components 
	 *  inside them. Every viewport has horizontal and vertical fractions which affecting the speed 
	 *  scrolling inside scroller component. */	
	public class Viewport extends Component implements IViewport
	{
		/** @private */
		private var _hFraction:Number;
		/** @private */
		private var _vFraction:Number;
		
		/** Constructor.
		 *  @param hFraction Horizontal fraction which affects the horizontal scrolling speed inside the scroller component.
		 *  @param vFraction Vertical fraction which affects the vertical scrolling speed inside the scroller component. */		
		public function Viewport(hFraction:Number=1, vFraction:Number=1)
		{
			super();
			
			_hFraction = hFraction;
			_vFraction = vFraction;
		}
		
		/** Horizontal fraction which affects the horizontal scrolling speed inside the scroller component. */		
		public function get hFraction():Number { return _hFraction; }
		public function set hFraction(value:Number):void { _hFraction = value; }
		
		/** Vertical fraction which affects the vertical scrolling speed inside the scroller component. */		
		public function get vFraction():Number { return _vFraction; }
		public function set vFraction(value:Number):void { _vFraction = value; }
	}
}
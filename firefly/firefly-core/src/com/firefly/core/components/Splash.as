// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.components
{
	import com.firefly.core.layouts.Layout;
	
	import flash.display.Sprite;
	
	/** Basic class of splash screen. This splash uses during application initialization. 
	 *  @example The following code shows how create own splash screen (e.g. company logo):
	 *  <listing version="3.0">
	 *************************************************************************************
public class CompanySplash extends Splash
{
	public function CompanySplash()
	{
		super();
		
		layout.addElement(new CompanyLogoFXG(), $width(50, true).pct, $vCenter(0), $hCenter(0));
	}
}
	 *************************************************************************************
	 *  </listing>  */
	public class Splash extends Sprite
	{
		private var _width:Number;
		private var _height:Number;
		private var _layout:Layout;
		
		/** Constructor.
		 *  @param layout Layout which be used to positioning elements. */	
		public function Splash(layout:Layout = null)
		{
			super();
			
			if (layout)
				_layout = layout;
			else
				_layout = new Layout(this);
		}

		/** @inheritDoc */
		override public function get width():Number { return !isNaN(_width) ? _width : super.width; }
		override public function set width(value:Number):void { _width = value; }
		/** @inheritDoc */
		override public function get height():Number { return !isNaN(_height) ? _height : super.height; }
		override public function set height(value:Number):void { _height = value; }
		
		/** Layout for positioning elements. */
		public function get layout():Layout { return _layout; }
		
		/** Update geometry of all elements in the container bases on layout. */
		public function updateLayout():void
		{
			_layout.layout();
		}
	}
}
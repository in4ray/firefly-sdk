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
	import com.firefly.core.display.IVScrollBar;
	
	import starling.display.Image;
	import starling.textures.Texture;
	
	/** The default vertical scrollbar component which added automatically to the scroller component 
	 *  in case is setted thumb texture in scroller constructor. */	
	public class DefaultVScrollBar extends Component implements IVScrollBar
	{
		/** @private */	
		private var _thumb:Image;
		
		/** Constructor.
		 *  @param thumbTexture Texture of vertical thumb. */
		public function DefaultVScrollBar(thumbTexture:Texture)
		{
			super();
			
			_thumb = new Image(thumbTexture);
			layout.addElement(_thumb);
		}
		
		/** Thumb image. */
		public function get thumb():Image { return _thumb; }
		/** Thumb width. */
		public function get thumbHeight():Number { return _thumb.height; }
		
		public function set thumbY(value:Number):void { _thumb.y = value; }
	}
}
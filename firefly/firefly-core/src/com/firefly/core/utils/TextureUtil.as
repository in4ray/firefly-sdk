// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.utils
{
	import com.firefly.core.Firefly;
	import com.firefly.core.firefly_internal;
	import com.firefly.core.layouts.LayoutContext;
	
	import flash.display.BitmapData;
	import flash.display.IBitmapDrawable;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	use namespace firefly_internal;
	
	/** Utility class that helps to create, scale and convert bitmap data. 
	 *  @see com.firefly.core.layouts.LayoutContext */	
	public class TextureUtil
	{
		private static var _helpMatirx:Matrix = new Matrix();
		
		/** Create and scale bitmap data from the source data.
		 * 
		 *  @param source Bitmap drawable data. E.g. FXG class or other bitmap data.
		 *  @param w Original width of the source data.
		 *  @param h Original height of the source data.
		 *  @param autoScale Specifies whether use autoscale algorithm. Based on design size and stage size texture will be 
		 * 		   proportionally scale to stage size. E.g. design size is 1024x768 and stage size is 800x600 the formula is
		 * 		   <code>var scale:Number = Math.min(1024/800, 768/600);</code></br> 
		 * 		   Calculated scale is 1.28 and all bitmaps scale based on it.
		 *  @param layoutContext Layout context to calculate the crop area for bitmap data.
		 *  @return Created BitmapData object.  */
		public static function createBitmapData(source:IBitmapDrawable, w:Number, h:Number, autoScale:Boolean = true, layoutContext:LayoutContext=null, canvas:BitmapData = null, position:Point = null):BitmapData
		{ 
			if (autoScale || layoutContext || canvas)
			{
				var scale:Number = autoScale ? Firefly.current._textureScale : 1;
				w = Math.ceil(w*scale);
				h = Math.ceil(h*scale);
				
				if(!canvas)
					canvas = new BitmapData(w, h, true, 0x00ffffff);
				
				if(!position)
					position = new Point();
				
				_helpMatirx.a = 1;
				_helpMatirx.b = 0;
				_helpMatirx.c = 0;
				_helpMatirx.d = 1;
				_helpMatirx.scale(scale, scale);
				_helpMatirx.tx = position.x;
				_helpMatirx.ty = position.y;
				
				if(layoutContext)
				{
					var rect:Rectangle = layoutContext.getTextureRect(w, h, layoutContext.vAlign, layoutContext.hAlign);
					_helpMatirx.tx = rect.x;
					_helpMatirx.ty = rect.y;
					rect.x = rect.y = 0;  
					canvas.draw(source, _helpMatirx, null, null, rect, true);
				}
				else
				{
					canvas.draw(source, _helpMatirx, null, null, null, true);
				}
			}
			else
			{
				if(source is BitmapData)
				{
					canvas = source as BitmapData;
				}
				else
				{
					canvas = new BitmapData(w, h, true, 0x00ffffff);
					canvas.draw(source, null, null, null, null, true);
				}
			}
			
			return canvas;
		}
	}
}
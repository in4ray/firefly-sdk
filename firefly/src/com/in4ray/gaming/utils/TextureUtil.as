// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.utils
{
	import com.in4ray.gaming.core.GameGlobals;
	
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import spark.core.SpriteVisualElement;
	
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/**
	 * Utility class that helps to create appropriate bitmap datas for textures. 
	 */	
	public class TextureUtil
	{
		/**
		 * @private 
		 */		
		private static function createFullScreenBitmapData(source:SpriteVisualElement, hAlign:String = HAlign.CENTER, vAlign:String = VAlign.CENTER):BitmapData
		{
			var width:Number = GameGlobals.stageSize.x / GameGlobals.contentScaleFactor;
			var height:Number = GameGlobals.stageSize.y / GameGlobals.contentScaleFactor;
			
			var factor:Number = Math.max(width/source.viewWidth, height/source.viewHeight);
			
			var hShift:Number = AlignUtil.alignHorizontal(width, source.viewWidth*factor, hAlign); 
			var vShift:Number = AlignUtil.alignVertical(height, source.viewHeight*factor, vAlign);
			
			var m:Matrix = new Matrix(factor, 0, 0, factor, hShift, vShift);
			var rect:Rectangle = new Rectangle(0,0, width, height);
			var data:BitmapData = new BitmapData(width, height, true, 0x00ffffff);
			
			data.draw(source, m, null, null, rect, true);
			
			return data;
		}
		
		/**
		 * Create texture bitmap data.
		 *  
		 * @param source FXG instance.
		 * @param hAlign Horizontal align.
		 * @param vAlign Vertical align.
		 * @return BitmapData of texture.
		 */		
		public static function createBitmapData(source:SpriteVisualElement, hAlign:String = HAlign.CENTER, vAlign:String = VAlign.CENTER):BitmapData
		{
			if(source.viewWidth >=  GameGlobals.designSize.x && source.viewHeight >=  GameGlobals.designSize.y)
			{
				return createFullScreenBitmapData(source, hAlign, vAlign);
			}
			
			var factor:Number = Math.max(GameGlobals.stageSize.x/GameGlobals.designSize.x, GameGlobals.stageSize.y/GameGlobals.designSize.y) / GameGlobals.contentScaleFactor;
			var m:Matrix = new Matrix(factor, 0, 0, factor);
			var data:BitmapData = new BitmapData(source.viewWidth*factor, source.viewHeight*factor, true, 0x00ffffff);
			data.draw(source, m, null, null, null, true);
			
			return data;
		}
		
		/**
		 * Get size of texture bitmap data that will be created from FXG file. 
		 * @param source FXG instance.
		 * @return Size of result texture.
		 */		
		public static function getBitmapDataSize(source:SpriteVisualElement):Point
		{
			if(source.viewWidth >=  GameGlobals.designSize.x && source.viewHeight >=  GameGlobals.designSize.y)
			{
				return new Point(GameGlobals.stageSize.x / GameGlobals.contentScaleFactor, GameGlobals.stageSize.y / GameGlobals.contentScaleFactor);
			}
			
			var factor:Number = Math.max(GameGlobals.stageSize.x/GameGlobals.designSize.x, GameGlobals.stageSize.y/GameGlobals.designSize.y) / GameGlobals.contentScaleFactor;
			
			return new Point(source.viewWidth*factor, source.viewHeight*factor);
		}
		
		/**
		 * Clip bitmapData by rectangle. 
		 * @param source BitmapData to be clipped.
		 * @param rect Rectangle of clipping.
		 * @return Clipped bitmapData.
		 */		
		public static function clipBitmapData(source:BitmapData, rect:Rectangle):BitmapData
		{
			var data:BitmapData = new BitmapData(rect.width, rect.height, true, 0x00ffffff);
			
			data.draw(source, new Matrix(1,0,0,1,-rect.x,-rect.y), null, null, new Rectangle(0, 0, rect.width, rect.height));
			
			return data;
		}
	}
}
// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.texturers.support
{
	import com.in4ray.gaming.utils.TextureUtil;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import starling.textures.SubTexture;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	[ExcludeClass]
	public class TextureData extends Rectangle
	{
		protected var sourceClass:Class;
		
		public function TextureData(sourceClass:Class, hAlign:String = HAlign.CENTER, vAlign:String = VAlign.CENTER)
		{
			this.vAlign = vAlign;
			this.hAlign = hAlign;
			this.sourceClass = sourceClass;
		}
		
		public var data:BitmapData;
		
		public function get loaded():Boolean
		{
			return data != null;
		}

		public var hAlign:String = HAlign.CENTER;
		
		public var vAlign:String = VAlign.CENTER;
		
		public function load(generateBitmap:Boolean = true):void
		{
			if(!data)
			{
				CONFIG::debugging {	var startTime:Number = new Date().time; };
				
				if(generateBitmap)
				{
					data = TextureUtil.createBitmapData(new sourceClass(), hAlign, vAlign);
					width = data.width;	
					height = data.height;
				}
				else
				{
					var size:Point = TextureUtil.getBitmapDataSize(new sourceClass());
					width = size.x;	
					height = size.y;
				}
				
				CONFIG::debugging {trace("[in4ray] loaded vector image " + sourceClass + ", time: " + (new Date().time - startTime) + " ms.")};
			}
		}
		
		public function release():void
		{
			data.dispose();
			data = null;
		}
		
		private var _texture:Texture;

		public function get texture():Texture
		{
			if(!_texture)
				_texture = new SubTexture(composer, this);
			
			return _texture;
		}
		
		public var composer:TextureComposer;
	}
}
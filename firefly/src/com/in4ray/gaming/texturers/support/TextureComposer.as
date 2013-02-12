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
	import com.in4ray.gaming.texturers.TextureBundle;
	
	import flash.display.BitmapData;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.textures.Texture;
	import flash.display3D.textures.TextureBase;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import avmplus.getQualifiedClassName;
	
	import starling.core.Starling;
	import starling.errors.MissingContextError;
	import starling.textures.Texture;
	import starling.utils.getNextPowerOfTwo;

	[ExcludeClass]
	public class TextureComposer extends starling.textures.Texture
	{
		private static const PADDING:int = 2;
		
		private var _width:Number;
		private var _height:Number;
		private var _bundle:TextureBundle;
		
		private var _base:flash.display3D.textures.Texture;
		
		public function TextureComposer(textureData:TextureData, bundle:TextureBundle, width:Number = NaN, height:Number = NaN)
		{
			var w:Number = getNextPowerOfTwo(textureData.width);
			var h:Number = getNextPowerOfTwo(textureData.height);
			
			_width = isNaN(width) ? w : Math.max(width, w);
			_height = isNaN(height) ? h : Math.max(height, h);
			/*_width = TextureConsts.MAX_WIDTH;
			_height = TextureConsts.MAX_HEIGHT;*/
			_bundle = bundle;
			attach(textureData);
		}
		
		private var textures:Vector.<TextureData> = new Vector.<TextureData>();
		
		public function attach(texture:TextureData):void
		{
			textures.push(texture);
			texture.composer = this;
			
			recalcFreeCells();
		}
		
		private function recalcFreeCells():void
		{
			_freeCells.length = 0;
			
			
			for each (var texture:TextureData in textures) 
			{
				var topRightRect:Rectangle = calcFreeCellByAdge(new Point(texture.right + PADDING, texture.top));
				if(topRightRect)
					_freeCells.push(topRightRect);
				
				var bottomLeftRect:Rectangle = calcFreeCellByAdge(new Point(texture.left, texture.bottom + PADDING));
				if(bottomLeftRect)
					_freeCells.push(bottomLeftRect);
			}
			
			_freeCells.sort(sortFunc);
			// simple way to get free cells (not optimal)
			/*var union:Rectangle = new Rectangle();
			for each (var texture:TextureData in tetures) 
			{
				union = union.union(texture);
			}
			_freeCells.push(new Rectangle(union.width, 0, width-union.width, height));
			_freeCells.push(new Rectangle(0, union.height, width, height-union.height));*/
		}
		
		private function sortFunc(a:Rectangle, b:Rectangle):int
		{
			if(a.width*a.height < a.width*a.height)
				return 1;
			else
				return -1;
		}
		
		private function calcFreeCellByAdge(point:Point):Rectangle
		{
			var rect:Rectangle  = new Rectangle(point.x, point.y, width - point.x, height - point.y);
			for each (var texture:TextureData in textures) 
			{
				if(rect.intersects(texture))
				{
					rect.width = texture.x - rect.x;
					rect.height = texture.y - rect.y;
				}
			}
			
			return rect.width > 0 || rect.height > 0 ? rect : null;
		}
		
		private var _freeCells:Vector.<Rectangle> = new Vector.<Rectangle>();
		
		public function get freeCells():Vector.<Rectangle>
		{
			return _freeCells;
		}
		
		public function get loaded():Boolean
		{
			return _base != null;
		}
		
		public function load():void
		{
			if(_base)
				return;
			
			var context:Context3D = Starling.context;
			
			if (context == null) throw new MissingContextError();
			
			CONFIG::debugging {	var startTime:Number = new Date().time; };
			
			var potData:BitmapData = new BitmapData(width, height, true, 0);
			
			for each (var texture:TextureData in textures) 
			{
				texture.load();
				
				potData.copyPixels(texture.data, texture.data.rect, new Point(texture.x, texture.y));
				
				texture.release();
			}
			
			_base = context.createTexture(
				_width, _height, Context3DTextureFormat.BGRA, _bundle.optimizedForRenderTexture);
			
			uploadBitmapData(_base, potData);
			
			//trace("dispose" + this)
			potData.dispose();
			
			CONFIG::debugging {trace("[in4ray] loaded composer, size: " + _width + "x" + _height + ", textures: " + textures.length + ", time: " + (new Date().time - startTime) + " ms.")};
		}
		
		public function release():void
		{
			if(_base)
				_base.dispose();
			_base = null;
		}
		
		
		/** Uploads the bitmap data to the native texture, optionally creating mipmaps. */
		protected function uploadBitmapData(nativeTexture:flash.display3D.textures.Texture,
												  data:BitmapData):void
		{
			nativeTexture.uploadFromBitmapData(data);
			
			if (_bundle.mipMapping && data.width > 1 && data.height > 1)
			{
				var currentWidth:int  = data.width  >> 1;
				var currentHeight:int = data.height >> 1;
				var level:int = 1;
				var canvas:BitmapData = new BitmapData(currentWidth, currentHeight, true, 0);
				var transform:Matrix = new Matrix(.5, 0, 0, .5);
				var bounds:Rectangle = new Rectangle();
				
				while (currentWidth >= 1 || currentHeight >= 1)
				{
					bounds.width = currentWidth; bounds.height = currentHeight;
					canvas.fillRect(bounds, 0);
					canvas.draw(data, transform, null, null, null, true);
					nativeTexture.uploadFromBitmapData(canvas, level++);
					transform.scale(0.5, 0.5);
					currentWidth  = currentWidth  >> 1;
					currentHeight = currentHeight >> 1;
				}
				
				canvas.dispose();
			}
		}
		
		
		/** Indicates if the base texture was optimized for being used in a render texture. */
		public function get optimizedForRenderTexture():Boolean { return _bundle.optimizedForRenderTexture; }
		
		/** @inheritDoc */
		public override function get base():TextureBase { return _base; }
		
		/** @inheritDoc */
		public override function get format():String { return Context3DTextureFormat.BGRA; }
		
		/** @inheritDoc */
		public override function get width():Number  { return _width;  }
		
		/** @inheritDoc */
		public override function get height():Number { return _height; }
		
		/** The scale factor, which influences width and height properties. */
		public override function get scale():Number { return 1; }
		
		/** @inheritDoc */
		public override function get mipMapping():Boolean { return _bundle.mipMapping; }
		
		/** @inheritDoc */
		public override function get premultipliedAlpha():Boolean { return _bundle.premultipliedAlpha; }
	}
}
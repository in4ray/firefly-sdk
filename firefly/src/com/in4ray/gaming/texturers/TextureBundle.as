// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.texturers
{
	import com.in4ray.gaming.async.callAsync;
	import com.in4ray.gaming.texturers.support.TextureComposer;
	import com.in4ray.gaming.texturers.support.TextureData;
	
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import avmplus.getQualifiedClassName;
	
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * Bubdle of textures that are positioned on one or several big testure atlases to get better performance. 
	 */	
	public class TextureBundle
	{
		private static const bundleMap:Dictionary = new Dictionary();
		
		/**
		 * Constructor.
		 *  
		 * @param mipMapping Indicates if the texture contains mip maps.
		 * @param premultipliedAlpha Indicates if the alpha values are premultiplied into the RGB values.
		 * @param optimizedForRenderTexture Indicates if the texture shold be optimized for rendering.
		 * 
		 */		
		public function TextureBundle(mipMapping:Boolean = false, premultipliedAlpha:Boolean = true, optimizedForRenderTexture:Boolean = false)
		{
			_bundleName = getQualifiedClassName(this);
			this.mipMapping = mipMapping;
			this.premultipliedAlpha = premultipliedAlpha;
			this.optimizedForRenderTexture = optimizedForRenderTexture;
		}
		
		private var _bundleName:String;

		/**
		 * Bundle name. 
		 */		
		public function get bundleName():String
		{
			return _bundleName;
		}

		
		private var _mipMapping:Boolean;
		
		/**
		 * Indicates if the texture contains mip maps. 
		 */		
		public function get mipMapping():Boolean
		{
			return _mipMapping;
		}
		
		public function set mipMapping(value:Boolean):void
		{
			if(_mipMapping != value)
			{
				if(initialized)
					throw Error("Bundle is already initialized.");
				_mipMapping = value;
			}
		}
		
		private var _premultipliedAlpha:Boolean = true;
		
		/**
		 * Indicates if the alpha values are premultiplied into the RGB values. 
		 */		
		public function get premultipliedAlpha():Boolean
		{
			return _premultipliedAlpha;
		}
		
		public function set premultipliedAlpha(value:Boolean):void
		{
			if(_premultipliedAlpha != value)
			{
				if(initialized)
					throw Error("Bundle is already initialized.");
				
				_premultipliedAlpha = value;
			}
		}
		
		private var _optimizedForRenderTexture:Boolean;
		
		/**
		 * Indicates if the texture shold be optimized for rendering. 
		 */		
		public function get optimizedForRenderTexture():Boolean
		{
			return _optimizedForRenderTexture;
		}
		
		public function set optimizedForRenderTexture(value:Boolean):void
		{
			if(_optimizedForRenderTexture != value)
			{
			if(initialized)
				throw Error("Bundle is already initialized.");
			
				_optimizedForRenderTexture = value;
			}
		}
		
		/**
		 * Width of texture atlas. 
		 */		
		public var composerWidth:Number;
		
		/**
		 * Width of texture atlas. 
		 */
		public var composerHeight:Number;
		
		private function get textureMap():Dictionary
		{
			var _textureMap:Dictionary = bundleMap[bundleName];
			if(!_textureMap)
			{
				_textureMap = new Dictionary();
				_textureMap["dataMap"] = new Dictionary();
				_textureMap["composers"] = new Vector.<TextureComposer>();
				_textureMap["initialized"] = false;
				bundleMap[bundleName] = _textureMap;
				
				registerTextures();
			}
			
			return _textureMap;
		}
		
		private function get dataMap():Dictionary
		{
			return textureMap["dataMap"];
		}
		
		private function get composers():Vector.<TextureComposer>
		{
			return textureMap["composers"];
		}
		
		/**
		 * Should be overrided to register textures. 
		 */		
		protected function registerTextures():void
		{
			// place to register all textures
		}
		
		/**
		 * Register texture.
		 *  
		 * @param sourceClass Texture FXG class.
		 * @param hAlign Horizontal align.
		 * @param vAlign Vertical align.
		 */		
		protected function registerTexture(sourceClass:Class, hAlign:String = HAlign.CENTER, vAlign:String = VAlign.CENTER):void
		{
			dataMap[sourceClass] = new TextureData(sourceClass, hAlign, vAlign);
		}
		
		/**
		 * Get texture by FXG class. Will force to initialize bundle if it isn't.
		 * @param sourceClass FXG class.
		 * @return Subtexture.
		 */		
		protected function getTexture(sourceClass:Class):Texture
		{
			if(!initialized)
				init();
			
			return (dataMap[sourceClass] as TextureData).texture;
		}
		
		/**
		 * Is bundle initialized. 
		 */		
		public function get initialized():Boolean
		{
			return textureMap["initialized"];
		}
		
		private function setInitialized(value:Boolean):void
		{
			textureMap["initialized"] = value;
		}
		
		/**
		 * Init bundle asyncronously. Use it if you want to show animated loading indicator.
		 *  
		 * @param generateBitmap Flag that indicates whether bitmap datas should be generated from FXG to further loading into GPU.
		 * @param callBack Function that will be called on complete of initialization.
		 * @param params Parameters for callback function.
		 */		
		public function initAsync(generateBitmap:Boolean = true, callBack:Function=null, ...params):void
		{
			if(!initialized)
			{			
				loadDataAsync(generateBitmap);
				callAsync(init, generateBitmap);
			}
			if(callBack != null)
				callAsync.apply(null, [callBack].concat(params));
		}
		
		private function loadDataAsync(generateBitmap:Boolean = true):void
		{
			for each (var textureData:TextureData in dataMap) 
			{
				if(!textureData.loaded)
					callAsync(textureData.load, generateBitmap);
			}
		}
		
		/**
		 * Initialize bundle synchronously.
		 *  
		 * @param generateBitmap Flag that indicates whether bitmap datas should be generated from FXG to further loading into GPU.
		 */		
		public function init(generateBitmap:Boolean = true):void
		{
			if(initialized)
				return;
			
			CONFIG::debugging {	var startTime:Number = new Date().time; };
			
			var textureData:TextureData;
			var list:Vector.<TextureData> = new Vector.<TextureData>();
			for each (textureData in dataMap) 
			{
				textureData.load(generateBitmap);
				list.push(textureData);
			}
			
			list.sort(textureSortFunc);
			
			for each (textureData in list) 
			{
				attachToAppropriateComposer(textureData);
			}
			
			CONFIG::debugging {trace("[in4ray] initialized bundle [" + bundleName + "], time: " + (new Date().time - startTime) + " ms.")};
			
			setInitialized(true);
		}
		
		private function attachToAppropriateComposer(texture:TextureData):void
		{
			for each (var composer:TextureComposer in composers) 
			{
				for each (var cell:Rectangle in composer.freeCells) 
				{
					if(cell.width >= texture.width && cell.height >= texture.height)
					{
						texture.x = cell.x;
						texture.y = cell.y;
						composer.attach(texture);
						return;
					}
				}
			}
			
			composers.push(new TextureComposer(texture, this, composerWidth, composerHeight));
		}
		
		private function textureSortFunc(t1:TextureData, t2:TextureData):int
		{
			if(t1.width*t1.height > t2.width*t2.height)
				return 1;
			else
				return -1;
		}
		
		/**
		 * Load bundle (send all bitmaps to GPU) asynchronously. Use it if you want to show animated loading indicator.
		 *  
		 * @param callBack Function that will be called on complete of loading.
		 * @param params Parameters for callback function.
		 */		
		public function loadAsync(callBack:Function=null, ...params):void
		{
			CONFIG::debugging {trace("[in4ray] loading bundle async [" + bundleName + "]")};
			initAsync();
			callAsync(function():void
			{
				for each (var composer:TextureComposer in composers) 
				{
					if(!composer.loaded)
						callAsync(composer.load);	
				}
			});
			
			if(callBack != null)
				callAsync.apply(null, [callBack].concat(params));
		}
		
		/**
		 * Load bundle (send all bitmaps to GPU) synchronously.
		 */		
		public function load():void
		{
			if(!initialized)
				init();
			
			CONFIG::debugging {	var startTime:Number = new Date().time; };
			
			for each (var composer:TextureComposer in composers) 
			{
				composer.load();	
			}
			CONFIG::debugging {trace("[in4ray] loaded bundle [" + bundleName + "], composers: " + composers.length + ", time: " + (new Date().time - startTime) + " ms.")};
		}
		
		/**
		 * Release textures from GPU. 
		 */		
		public function release():void
		{
			CONFIG::debugging {trace("[in4ray] releasing bundle [" + bundleName + "], composers: " + composers.length)};
			
			for each (var composer:TextureComposer in composers) 
			{
				composer.release();	
			}
		}
	}
}
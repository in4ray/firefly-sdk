// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.textures.helpers
{
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;
	import com.firefly.core.utils.TextureUtil;
	import com.firefly.core.utils.XMLUtil;
	
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import dragonBones.core.dragonBones_internal;
	import dragonBones.factorys.StarlingFactory;
	import dragonBones.objects.DataParser;
	import dragonBones.objects.DecompressedData;
	import dragonBones.objects.SkeletonData;
	import dragonBones.textures.ITextureAtlas;
	import dragonBones.textures.StarlingTextureAtlas;
	
	import starling.core.Starling;
	import starling.core.starling_internal;
	import starling.events.Event;
	import starling.textures.Texture;
	
	use namespace dragonBones_internal;
	
	/** The Dragon Bones factory for building and creation textures for Dragon Bones. */
	public class DragonBonesFactory extends StarlingFactory
	{
		private static const _loaderContext:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
		
		private var _completer:Completer;
		private var _atlasName:String;
		private var _autoScale:Boolean;
		
		/** Constructor. */
		public function DragonBonesFactory()
		{
			super();
			
			_loaderContext.allowCodeImport = true;
		}
	
		/** Create Dragon Bones textures from the byte array and save in the bundle.
		 *  @param data Byte array for textures creation.
		 *  @param autoScale Specifies whether use autoscale algorithm. **/
		public function load(bytes:ByteArray, autoScale:Boolean = true):Future
		{
			if(!bytes)
			{
				throw new ArgumentError();
			}
			
			this._autoScale = autoScale;
			
			var decompressedData:DecompressedData = DataParser.decompressData(bytes);
			var xml:XML = XML(decompressedData.dragonBonesData)
			var data:SkeletonData = DataParser.parseData(autoScale ? XMLUtil.adjustDragonBonesXML(xml) : xml);
			
			var dataName:String = data.name;
			addSkeletonData(data, dataName);
			var loader:Loader = new Loader();
			loader.name = dataName;
			_textureAtlasLoadingDic[dataName] = decompressedData.textureAtlasData;
			loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, loaderCompleteHandler);
			loader.loadBytes(decompressedData.textureBytes, _loaderContext);
			decompressedData.dispose();
			
			_completer = new Completer();
			
			return _completer.future;
		}
		
		/** @private */
		override protected function loaderCompleteHandler(e:flash.events.Event):void
		{
			var loader:Loader = e.target.loader;
			_atlasName = loader.name;
			
			super.loaderCompleteHandler(e);
			
			_completer.complete();
		}
		
		/** @inheritDoc */
		override protected function generateTextureAtlas(content:Object, textureAtlasRawData:Object):ITextureAtlas
		{
			var xml:XML;
			var texture:Texture;
			var bitmapData:BitmapData;
			if (content is BitmapData)
			{
				bitmapData = content as BitmapData;
				bitmapData = TextureUtil.createBitmapData(bitmapData, bitmapData.width, bitmapData.height, _autoScale);
			}
			else if (content is MovieClip)
			{
				var movieClip:MovieClip = content as MovieClip;
				movieClip.gotoAndStop(1);
				bitmapData = TextureUtil.createBitmapData(movieClip, movieClip.width, movieClip.height, _autoScale);
				movieClip.gotoAndStop(movieClip.totalFrames);
			}
			else
			{
				throw new Error();
			}	
			
			var textureAtlas:StarlingTextureAtlas = getTextureAtlas(_atlasName) as StarlingTextureAtlas;
			if(textureAtlas)
			{
				restoreTexture(textureAtlas, bitmapData);
			}
			else
			{
				texture = Texture.fromBitmapData(bitmapData, generateMipMaps, optimizeForRenderToTexture);
				xml = XML(textureAtlasRawData);
				textureAtlas = new StarlingTextureAtlas(texture, _autoScale ? XMLUtil.adjustAtlasXML(xml) : xml, false);
			}
			
			textureAtlas.texture.root.onRestore = null;
			
			bitmapData.dispose();
			
			return textureAtlas;
		}
		
		/** @private */
		private function restoreTexture(atlas:StarlingTextureAtlas, data:BitmapData):void
		{
			atlas.texture.root.starling_internal::createBase();
			atlas.texture.root.uploadBitmapData(data);
		}
		
		/** Release loaded data. */	
		public function unload():void
		{
			var existedAtlas:StarlingTextureAtlas = getTextureAtlas(_atlasName) as StarlingTextureAtlas;
			if(existedAtlas)
			{
				existedAtlas.texture.base.dispose();
			}
		}
	}
}
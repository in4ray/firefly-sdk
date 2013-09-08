// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.textures
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.textures.loaders.AtlasATFLoader;
	import com.firefly.core.textures.loaders.AtlasBitmapLoader;
	import com.firefly.core.textures.loaders.AtlasFXGLoader;
	import com.firefly.core.utils.Log;
	
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	use namespace firefly_internal;
	
	/** StaticTexture bundle class for loading, creating and storing different types of created texture atlases as
	 *  bitmap atlas (PNG/JPEG), ATF atlas.
	 * 
	 * 	@see com.firefly.core.textures.TextureBundle
	 *  @see com.firefly.core.textures.DynamicTextureBundle
	 *  @see com.firefly.core.assets.AssetState
	 * 	
	 *  @example The following code shows how to register different types of texture atlases:
	 *  <listing version="3.0">
	 *************************************************************************************
public class GameTextureBundle extends TextureBundle
{
	 override protected function regTextures():void
	 {
		 regBitmapTextureAtlas("bitmap_atlas", "../textures/bitmap_atlas.png", "../textures/bitmap_atlas.xml");
		 regATFTextureAtlas("atf_atlas", "../textures/atf_atlas.atf", "../textures/atf_atlas.xml");
	 }
}
	 *************************************************************************************
	 *  </listing> */	
	public class StaticTextureBundle extends TextureBundle
	{
		/** @private */
		firefly_internal var textureAtlases:Dictionary;
		
		/** @inheritDoc */
		public function StaticTextureBundle(generateMipMaps:Boolean = false)
		{
			super(generateMipMaps);
			
			if(singleton == this)
				textureAtlases = new Dictionary();
		}
		
		/** @private */
		private function get staticSingleton():StaticTextureBundle
		{
			return singleton as StaticTextureBundle;
		}
		
		/** Register bitmap based texture atlas (PNG/JPEG) for loading.
		 * 
		 *  @param id Unique identifier of the texture atlas.
		 *  @param bitmapPath Path to the bitmap file.
		 * 	@param xmlPath Path to the xml file.
		 *  @param autoScale Specifies whether use autoscale algorithm. Based on design size and stage size texture will be 
		 * 		   proportionally scale to stage size. E.g. design size is 1024x768 and stage size is 800x600 the formula is
		 * 		   <code>var scale:Number = Math.min(1024/800, 768/600);</code></br> 
		 * 		   Calculated scale is 1.28, all bitmaps and described textures in xml scale based on it.
		 *  @param checkPolicyFile Specifies whether the application should attempt to download a URL 
		 * 		   policy file from the loaded object's server before beginning to load the object itself. */
		protected function regBitmapTextureAtlas(id:String, bitmapPath:String, xmlPath:String, autoScale:Boolean = true, checkPolicyFile:Boolean = false):void
		{
			if(singleton != this)
				return staticSingleton.regBitmapTextureAtlas(id, bitmapPath, xmlPath, autoScale, checkPolicyFile);
			
			if(!(id in loaders))
				loaders[id] = new AtlasBitmapLoader(id, bitmapPath, xmlPath, autoScale, checkPolicyFile);
		}
		
		/** Register ATF based texture atlas for loading.

		 *  @param id Unique identifier of the loader.
		 *  @param bitmapPath Path to the bitmap file.
		 * 	@param atfPath Path to ATF file.
		 * 	@param xmlPath Path to the xml file. */
		protected function regATFTextureAtlas(id:String, atfPath:String, xmlPath:String):void
		{
			if(singleton != this)
				return staticSingleton.regATFTextureAtlas(id, atfPath, xmlPath);
			
			if(!(id in loaders))
				loaders[id] = new AtlasATFLoader(id, atfPath, xmlPath);
		}
		
		/** Register FXG based texture atlas for loading.
		 *
		 *  @param source Source class of FXG data.
		 *  @param autoScale Specifies whether use autoscale algorithm. Based on design size and stage size texture will be 
		 * 		   proportionally scale to stage size. E.g. design size is 1024x768 and stage size is 800x600 the formula is
		 * 		   <code>var scale:Number = Math.min(1024/800, 768/600);</code></br> 
		 * 		   Calculated scale is 1.28 and all bitmaps scale based on it. */
		protected function regFXGTextureAtlas(source:Class, autoScale:Boolean = true):void
		{
			if(singleton != this)
				return staticSingleton.regFXGTextureAtlas(source, autoScale);
			
			if(!(source in loaders))
				loaders[source] = new AtlasFXGLoader(source, autoScale);
		}
		
		/** Return texture atlas by unique identifier. This method uses to get texture atlases created from PNG/JPEG and ATF
		 * 	texture data formats.
		 *  @param id Unique identifier of the texture atlas.
		 *  @return Texture Atlas object stored in the bundle. */
		public function getTextureAtlas(name:*):TextureAtlas
		{
			if(singleton != this)
				return staticSingleton.getTextureAtlas(name);
			
			if(name in textureAtlases)
				return textureAtlases[name];
			
			CONFIG::debug {
				Log.error("Texture atlas {0} is not found.", name);
			};
			
			return null;
		}
		
		/** @private
		 *  Create texture atlas from the bitmap data and save in the bundle.
		 * 	@param id Unique identifier of the texture atlas.
		 *  @param bitmapData Bitmap data for texture atlas creation.
		 *  @param xml XML data for texture atlas creation. **/
		firefly_internal function createTextureAtlasFromBitmapData(id:*, bitmapData:BitmapData, xml:XML):void
		{
			var textureAtlas:TextureAtlas = textureAtlases[id]
			if (!textureAtlas)
			{
				textureAtlas = new TextureAtlas(Texture.fromBitmapData(bitmapData, generateMipMaps), xml);
				textureAtlases[id] = textureAtlas;
			}
			else
			{
				textureAtlas.texture.root.onRestore = function():void
				{
					textureAtlas.texture.root.uploadBitmapData(bitmapData);
				};
				Starling.current.dispatchEvent(new Event(Event.CONTEXT3D_CREATE));
			}
			
			textureAtlas.texture.root.onRestore = null;		
		}
		
		/** @private
		 *  Create texture atlas from the byte array and save in the bundle.
		 * 	@param id Unique identifier of the texture atlas.
		 *  @param data Byte data for texture atlas creation.
		 *  @param xml XML data for texture atlas creation. **/
		firefly_internal function createTextureAtlasFromByteArray(id:*, data:ByteArray, xml:XML):void
		{
			var textureAtlas:TextureAtlas = textureAtlases[id]
			if (!textureAtlas)
			{
				textureAtlas = new TextureAtlas(Texture.fromAtfData(data, 1, generateMipMaps), xml);
				textureAtlases[id] = textureAtlas;
			}
			else
			{
				textureAtlas.texture.root.onRestore = function():void
				{
					textureAtlas.texture.root.uploadAtfData(data);
				};
				Starling.current.dispatchEvent(new Event(Event.CONTEXT3D_CREATE));
			}
			
			textureAtlas.texture.root.onRestore = null;		
		}
		
		/** @inheritDoc */
		override public function release():void
		{
			super.release();
			
			for each (var ta:TextureAtlas in textureAtlases) 
			{
				ta.dispose();
			}
		}
	}
}
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
	import com.firefly.core.assets.IAssetBundle;
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;
	import com.firefly.core.async.GroupCompleter;
	import com.firefly.core.concurrency.GreenThread;
	import com.firefly.core.textures.helpers.DragonBonesFactory;
	import com.firefly.core.textures.loaders.ATFLoader;
	import com.firefly.core.textures.loaders.AtlasATFLoader;
	import com.firefly.core.textures.loaders.AtlasBitmapLoader;
	import com.firefly.core.textures.loaders.AtlasFXGLoader;
	import com.firefly.core.textures.loaders.BitmapLoader;
	import com.firefly.core.textures.loaders.DragonBonesLoader;
	import com.firefly.core.textures.loaders.FXGLoader;
	import com.firefly.core.textures.loaders.ITextureLoader;
	import com.firefly.core.textures.loaders.SWFLoader;
	import com.firefly.core.utils.Log;
	import com.firefly.core.utils.SingletonLocator;
	
	import flash.display.BitmapData;
	import flash.display3D.Context3D;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import avmplus.getQualifiedClassName;
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	use namespace firefly_internal;
	
	/** Texture bundle class for loading, creating and storing different types of textures as
	 *  Bitmap (PNG/JPEG), FXG, ATF and Dragon Bones.
	 * 
	 *  @see com.firefly.core.assets.AssetState
	 * 	
	 *  @example The following code shows how to register different types of textures:
	 *  <listing version="3.0">
	 *************************************************************************************
public class GameTextureBundle extends TextureBundle
{
	override protected function regTextures():void
	{
		regFXGTexture(PauseButton);
		regBitmapTexture("bitmap_texture_1", "../textures/texture1.png");
		regBitmapTexture("bitmap_texture_2", "../textures/texture2.jpg");
		regATFTexture("atf_texture", "../textures/atf_texture.atf");
		regSWFTexture("swf_textures", "../textures/swf_textures.swf");
		regDragonBonesFactory("dragon_bones", "../textures/DragonBones.swf");	
		regBitmapTextureAtlas("bitmap_atlas", "../textures/bitmapTextureAtlas.png", "../textures/bitmapTextureAtlas.xml");
		regBitmapATFAtlas("bitmap_atlas", "../textures/atfTextureAtlas.atf", "../textures/atfTextureAtlas.xml");
		regFXGTextureAtlas(FXGTextureAtlas);
	}
}
	 *************************************************************************************
	 *  </listing> */	
	public class TextureBundle implements IAssetBundle
	{
		protected static const thread:GreenThread = new GreenThread();
		
		/** @private */
		firefly_internal var loaders:Dictionary;
		/** @private */
		firefly_internal var textures:Dictionary;
		/** @private */
		firefly_internal var textureLists:Dictionary;
		/** @private */
		firefly_internal var dbFactories:Dictionary;
		/** @private */
		firefly_internal var textureAtlases:Dictionary;
		
		private var _name:String;
		private var _context3d:Context3D;
		
		protected var generateMipMaps:Boolean;
		protected var singleton:TextureBundle;
		
		/** Constructor. 
		 *  @param useMipMaps Indicates if mipMaps will be created for all registered textures.*/
		public function TextureBundle(generateMipMaps:Boolean = false)
		{
			this._name = getQualifiedClassName(this);
			this.generateMipMaps = generateMipMaps;
			this.singleton = SingletonLocator.getInstance(getDefinitionByName(_name) as Class, this);
			
			if(singleton == this)
			{
				loaders = new Dictionary();
				textures = new Dictionary();
				dbFactories = new Dictionary();
				textureLists = new Dictionary();
				textureAtlases = new Dictionary();
				regTextures();
			}
		}
		
		/** Unique name of bundle. */
		public function get name():String { return _name; }
		
		/** Register FXG based texture (embeded source class) for loading.
		 * 
		 *  @param source Source class of FXG data.
		 *  @param autoScale Specifies whether use autoscale algorithm. Based on design size and stage size texture will be 
		 * 		   proportionally scale to stage size. E.g. design size is 1024x768 and stage size is 800x600 the formula is
		 * 		   <code>var scale:Number = Math.min(1024/800, 768/600);</code></br> 
		 * 		   Calculated scale is 1.28 and all bitmaps scale based on it.
		 *  @param keepStageAspectRatio Specifies whether keep stage aspect ration. This property has effect to cropping of bitmap data. 
		 *  @param vAlign Vertical align type.
		 *  @param hAlign Horizontal align type. */	
		protected function regFXGTexture(source:Class, autoScale:Boolean = true, keepStageAspectRatio:Boolean = false, vAlign:String = "", hAlign:String = ""):void
		{
			if(singleton != this)
				return singleton.regFXGTexture(source, autoScale, keepStageAspectRatio, vAlign, hAlign);
			
			if(!(source in loaders))
				loaders[source] = new FXGLoader(source, autoScale, keepStageAspectRatio, vAlign, hAlign);
		}
		
		/** Register bitmap based texture (PNG/JPEG) for loading.
		 * 
		 *  @param id Unique identifier of the texture.
		 *  @param path Path to the bitmap file.
		 *  @param autoScale Specifies whether use autoscale algorithm. Based on design size and stage size texture will be 
		 * 		   proportionally scale to stage size. E.g. design size is 1024x768 and stage size is 800x600 the formula is
		 * 		   <code>var scale:Number = Math.min(1024/800, 768/600);</code></br> 
		 * 		   Calculated scale is 1.28 and all bitmaps scale based on it.
		 *  @param keepStageAspectRatio Specifies whether keep stage aspect ration. This property has effect to cropping of bitmap data. 
		 *  @param vAlign Vertical align type.
		 *  @param hAlign Horizontal align type. 
		 *  @param checkPolicyFile Specifies whether the application should attempt to download a URL 
		 * 		   policy file from the loaded object's server before beginning to load the object itself. */	
		protected function regBitmapTexture(id:String, path:String, autoScale:Boolean = true, keepStageAspectRatio:Boolean = false, vAlign:String = "", hAlign:String = "", checkPolicyFile:Boolean = false):void
		{
			if(singleton != this)
				return singleton.regBitmapTexture(id, path, autoScale, keepStageAspectRatio, vAlign, hAlign, checkPolicyFile);
			
			if(!(id in loaders))
				loaders[id] = new BitmapLoader(id, path, autoScale, keepStageAspectRatio, vAlign, hAlign, checkPolicyFile);
		}
		
		/** Register ATF based texture for loading.
		 *  @param id Unique identifier of the texture.
		 *  @param path Path to the ATF file. */
		protected function regATFTexture(id:String, path:String):void
		{
			if(singleton != this)
				return singleton.regATFTexture(id, path);
			
			if(!(id in loaders))
				loaders[id] = new ATFLoader(id, path);
		}
		
		/** Register SWF based texture for loading.
		 * 
		 *  @param id Unique identifier of the texture.
		 *  @param path Path to the SWF file.
		 *  @param autoScale Specifies whether use autoscale algorithm. Based on design size and stage size texture will be 
		 * 		   proportionally scale to stage size. E.g. design size is 1024x768 and stage size is 800x600 the formula is
		 * 		   <code>var scale:Number = Math.min(1024/800, 768/600);</code></br> 
		 * 		   Calculated scale is 1.28 and all bitmaps scale based on it.
		 *  @param keepStageAspectRatio Specifies whether keep stage aspect ration. This property has effect to cropping of bitmap data. 
		 *  @param vAlign Vertical align type.
		 *  @param hAlign Horizontal align type. 
		 *  @param checkPolicyFile Specifies whether the application should attempt to download a URL 
		 * 		   policy file from the loaded object's server before beginning to load the object itself. */	
		protected function regSWFTexture(id:String, path:String, autoScale:Boolean = true, keepStageAspectRatio:Boolean = false, vAlign:String = "", hAlign:String = "", checkPolicyFile:Boolean = false):void
		{
			if(singleton != this)
				return singleton.regSWFTexture(id, path, autoScale, keepStageAspectRatio, vAlign, hAlign, checkPolicyFile);
			
			if(!(id in loaders))
				loaders[id] = new SWFLoader(id, path, autoScale, keepStageAspectRatio, vAlign, hAlign, checkPolicyFile);
		}
		
		/** Register Dragon Bones based textures for loading.
		 * 
		 *  @param id Unique identifier of the dragon bones texture factory.
		 *  @param path Path to the SWF file. 
		 *  @param autoScale Specifies whether use autoscale algorithm. Based on design size and stage size texture will be 
		 * 		   proportionally scale to stage size. E.g. design size is 1024x768 and stage size is 800x600 the formula is
		 * 		   <code>var scale:Number = Math.min(1024/800, 768/600);</code></br> 
		 * 		   Calculated scale is 1.28 and all Dragon Bones textures scale based on it. */
		protected function regDragonBonesFactory(id:String, path:String, autoScale:Boolean = true):void
		{
			if(singleton != this)
				return singleton.regDragonBonesFactory(id, path, autoScale);
			
			if(!(id in loaders))
				loaders[id] = new DragonBonesLoader(id, path, autoScale);
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
				return singleton.regBitmapTextureAtlas(id, bitmapPath, xmlPath, autoScale, checkPolicyFile);
			
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
				return singleton.regATFTextureAtlas(id, atfPath, xmlPath);
			
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
				return singleton.regFXGTextureAtlas(source, autoScale);
			
			if(!(source in loaders))
				loaders[source] = new AtlasFXGLoader(source, autoScale);
		}
		
		/** Register textures. This method calls after creation of the texture bundle. */
		protected function regTextures():void
		{
			
		}
		
		/** Return texture by unique identifier. This method uses to get texture created from PNG/JPEG, FXG, ATF and 
		 * 	SWF (when file has has just one texture) texture data formats.
		 *  @param id Unique identifier of the texture.
		 *  @return Texture object stored in the bundle. */
		public function getTexture(id:*):Texture
		{
			if(singleton != this)
				return singleton.getTexture(id);
			
			if(id in textures)
				return textures[id];
			
			CONFIG::debug {
				Log.error("Texture {0} is not found.", id);
			};
			
			return null;
		}
		
		/** Return textures list by unique identifier. This method uses to get textures from loaded SWF file when it has more then one texture.
		 *  @param id Unique identifier of the texture list.
		 *  @return Texture object stored in the bundle. */
		public function getTextureList(name:*):Vector.<Texture>
		{
			if(singleton != this)
				return singleton.getTextureList(name);
			
			if(name in textureLists)
				return textureLists[name];
			
			CONFIG::debug {
				Log.error("Texture List {0} is not found.", name);
			};
			
			return null;
		}
		
		/** Return texture atlas by unique identifier. This method uses to get texture atlases created from PNG/JPEG and ATF
		 * 	texture data formats.
		 *  @param id Unique identifier of the texture atlas.
		 *  @return Texture Atlas object stored in the bundle. */
		public function getTextureAtlas(name:*):TextureAtlas
		{
			if(singleton != this)
				return singleton.getTextureAtlas(name);
			
			if(name in textureAtlases)
				return textureAtlases[name];
			
			CONFIG::debug {
				Log.error("Texture atlas {0} is not found.", name);
			};
			
			return null;
		}
		
		/** Return Dragon Bones factory by unique identifier.
		 *  @param id Unique identifier of the factory.
		 *  @return Dragon Bones factory stored in the bundle. */
		public function getDragonBonesFactory(id:String):DragonBonesFactory
		{
			if(singleton != this)
				return singleton.getDragonBonesFactory(id);
			
			if(id in dbFactories)
				return dbFactories[id];
			
			CONFIG::debug {
				Log.error("Dragon Bones Factory {0} is not found.", id);
			};
			
			return null;
		}
		
		/** Load all registered textures asynchronously. 
		 *  @return Future object for callback. */
		public function load():Future
		{
			if(singleton != this)
				return singleton.load();
			
			if (!_context3d || _context3d.driverInfo == "Disposed" || _context3d != Starling.context)
			{
				_context3d = Starling.context;
				
				var group:GroupCompleter = new GroupCompleter();
				for each (var loader:ITextureLoader in loaders) 
				{
					var completer:Completer = new Completer();
					
					thread.schedule(loader.load).then(onTextureLoaded, loader, completer);
					
					group.append(completer.future);
				}
				
				return group.future;	
			}
			
			return Future.nextFrame();
		}
		
		/** @private */
		private function onTextureLoaded(loader:ITextureLoader, completer:Completer):void
		{
			var future:Future = loader.build(this);
			loader.unload();
			
			if(future)
				future.then(completer.complete);
			else
				completer.complete();
		}
		
		/** Unload all types of textures from the current bundle. */
		public function unload():void
		{
			if(singleton != this)
				return singleton.unload();
			
			var texture:Texture;
			for each (texture in textures) 
			{
				texture.root.base.dispose();
			}
			
			for each (var textureList:Vector.<Texture> in textureLists) 
			{
				for each (texture in textureList) 
				{
					texture.root.base.dispose();
				}
			}
			
			for each (var factory:DragonBonesFactory in dbFactories) 
			{
				factory.unload();
			}
			
			_context3d = null;
		}
		
		
		/** @private
		 *  Create texture from the bitmap data and save in the bundle.
		 * 	@param id Unique identifier of the texture.
		 *  @param bitmapData Bitmap data for texture creation. **/
		firefly_internal function createTextureFromBitmapData(id:*, bitmapData:BitmapData):void
		{
			var texture:Texture = textures[id];
			if (!texture)
			{
				texture = Texture.fromBitmapData(bitmapData, generateMipMaps);
				textures[id] = texture;
			}
			else
			{
				texture.root.onRestore = function():void
				{
					texture.root.uploadBitmapData(bitmapData);
				};
				Starling.current.dispatchEvent(new Event(Event.CONTEXT3D_CREATE));
			}
			
			texture.root.onRestore = null;
		}
		
		/** @private
		 *  Create texture from the byte array and save in the bundle.
		 * 	@param id Unique identifier of the texture.
		 *  @param data Byte array for texture creation. **/
		firefly_internal function createTextureFromByteArray(id:*, data:ByteArray):void
		{
			var texture:Texture = textures[id];
			if (!texture)
			{
				texture = Texture.fromAtfData(data, 1, generateMipMaps);
				textures[id] = texture;
			}
			else
			{
				texture.root.onRestore = function():void
				{
					texture.root.uploadAtfData(data);
				};
				Starling.current.dispatchEvent(new Event(Event.CONTEXT3D_CREATE));
			}
			
			texture.root.onRestore = null;
		}
		
		/** @private
		 *  Create texture or textue list from the list of the bitmap data and save in the bundle.
		 * 	@param id Unique identifier of the texture or texture list.
		 *  @param bitmapDataList Vector of bitmap datas. **/
		firefly_internal function createTextureFromBitmapDataList(id:*, bitmapDataList:Vector.<BitmapData>):void
		{
			var textureList:Vector.<Texture> = textureLists[id];
			var texture:Texture;
			if (!textureList)
			{
				textureList = new Vector.<Texture>();
				for each (var bitmapData:BitmapData in bitmapDataList) 
				{
					texture = Texture.fromBitmapData(bitmapData, generateMipMaps);
					texture.root.onRestore = null;
					textureList.push(texture);
				}
				
				textureLists[id] = textureList;
			}
			else
			{
				for (var i:int = 0; i < textureList.length; i++) 
				{
					texture = textureList[i];
					
					texture.root.onRestore = function():void
					{
						texture.root.uploadBitmapData(bitmapDataList[i]);
					};
					Starling.current.dispatchEvent(new Event(Event.CONTEXT3D_CREATE));
					texture.root.onRestore = null;
				}
			}
		}
		
		
		/** @private
		 *  Create Dragon Bones textures factory from the byte array and save in the bundle.
		 * 	@param id Unique identifier of the factory.
		 *  @param data Byte array for textures creation.
		 *  @param autoScale Specifies whether use autoscale algorithm.
		 *  @return Future object for callback. **/
		firefly_internal function createTextureForDragonBones(id:*, data:ByteArray, autoScale:Boolean = true):Future
		{
			var future:Future;
			var factory:DragonBonesFactory = dbFactories[id];
			if (!factory)
			{
				factory = new DragonBonesFactory();
				factory.generateMipMaps = generateMipMaps;
				dbFactories[id] = factory;
			}
			
			future = factory.load(data, autoScale);
			
			return future;
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
	}
}
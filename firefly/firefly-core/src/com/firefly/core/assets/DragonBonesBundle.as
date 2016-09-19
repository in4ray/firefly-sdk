// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.assets
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.assets.loaders.DBJSONLoader;
	import com.firefly.core.assets.loaders.DBXMLLoader;
	import com.firefly.core.assets.loaders.ITextFileLoader;
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;
	import com.firefly.core.async.GroupCompleter;
	import com.firefly.core.components.DBAnimation;
	import com.firefly.core.concurrency.GreenThread;
	import com.firefly.core.utils.CommonUtils;
	import com.firefly.core.utils.Log;
	import com.firefly.core.utils.SingletonLocator;
	
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import avmplus.getQualifiedClassName;
	
	import dragonBones.Armature;
	import dragonBones.objects.DragonBonesData;
	
	import starling.StarlingFactory;
	import starling.textures.TextureAtlas;
	
	use namespace firefly_internal;
	
	/** Dragon Bones bundle class for loading, creating and storing armatures.
	 *  
	 *  @example The following code shows how to register skeleton animation json/xml for loading:
	 *  <listing version="3.0">
	 *************************************************************************************
 public class GameDBBundle extends DragonBonesBundle
 {
 	override protected function regDranonBonesSkeletons():void
	{
		regDragonBonesJSON("Dragon", "../anims/dragon.json");
		regDragonBonesXML("Robot", "../anims/robot.xml");
	}
 
	public function get dragonArmature():Armature { return getArmature("Dragon"); }
 }
	 *************************************************************************************
	 *  </listing> 
	 *	@example The following code shows how to create armature in case the skeleton animation json/xml file is loaded by
	 * 	DragonBonesBundle class:
	 *  <listing version="3.0">
	 *************************************************************************************
 public class MySprite extends Sprite
 {
 	public function MySprite()
	{
		super();
		
		var textureBundle:MyTextureBundle = new MyTextureBundle();
		var dbBundle:GameDBBundle = new GameDBBundle();
		var dragon:Armature = dbBundle.buildArmature("Dragon", textureBundle.getTextureAtlas("dragonAtlas"));
	}
 }
	 *************************************************************************************
	 *  </listing> */	
	public class DragonBonesBundle implements IAssetBundle
	{
		/** @private */
		protected static const thread:GreenThread = new GreenThread();
		
		/** @private */
		firefly_internal var _loaders:Dictionary;
		/** @private */
		firefly_internal var _dbData:Dictionary;
		/** @private */
		firefly_internal var _animations:Dictionary;
		/** @private */
		firefly_internal var _factory:StarlingFactory;
		
		/** @private */
		private var _name:String;
		/** @private */
		private var _loaded:Boolean;
		
		/** @private */
		protected var _singleton:DragonBonesBundle;
		
		/** Constructor. */
		public function DragonBonesBundle()
		{
			this._name = getQualifiedClassName(this);
			this._singleton = SingletonLocator.getInstance(getDefinitionByName(_name) as Class, this);
			
			if(_singleton == this)
			{
				_loaders = new Dictionary();
				_dbData = new Dictionary();
				_animations = new Dictionary();
				_factory = new StarlingFactory();
				regDranonBonesSkeletons();
			}
		}
		
		/** Unique name of bundle. */
		public function get name():String { return _name; }
		
		/** Return dragon bones data by unique identifier.
		 *  @param id Unique identifier of the data.
		 *  @return Dragon bones data stored in the bundle. */
		public function getDragonBonesData(id:String):DragonBonesData
		{
			if(_singleton != this)
				return _singleton.getDragonBonesData(id);
			
			if(id in _dbData)
				return _dbData[id];
			
			CONFIG::debug {
				Log.error("Dragon bones data {0} is not found.", id);
			};
			
			return null;
		}
		
		/** Return animation with wrapped armature by unique identifier.
		 *  @param id Unique identifier of the animation.
		 *  @return Animation stored in the bundle. */
		public function getAnimation(id:String):DBAnimation
		{
			if(_singleton != this)
				return _singleton.getAnimation(id);
			
			if(id in _animations)
				return _animations[id];
			
			CONFIG::debug {
				Log.error("Animation {0} is not found.", id);
			};
			
			return null;
		}
		
		/** Load dragon bones assets asynchronously.
		 *  @return Future object for callback. */
		public function load():Future
		{
			if(_singleton != this)
				return _singleton.load();
			
			if(isDirty() && !CommonUtils.isEmptyDict(_loaders))
			{
				var group:GroupCompleter = new GroupCompleter();
				for each (var loader:ITextFileLoader in _loaders) 
				{
					var completer:Completer = new Completer();
					thread.schedule(loader.load).then(onSkeletonFileLoaded, loader, completer);
					group.append(completer.future);
				}
				
				_loaded = true;
				
				return group.future;
			}
			return Future.nextFrame();
		}
		
		/** Release dragon bones data. */		
		public function unload():void
		{
			if(_singleton != this)
				return _singleton.unload();
			
			_loaded = false;
		}
		
		/** @inheritDoc */	
		public function isDirty():Boolean
		{
			if(_singleton != this)
				return _singleton.isDirty();
			
			return !_loaded && !CommonUtils.isEmptyDict(_loaders);
		}
		
		/** Create and store animation using loaded xml/json file and bitmap texture atlas from 
		 *  the param. The identifier should be the same as registered skeleton xml/json.
		 * 	@param id Unique identifier of the animation.
		 * 	@param textureAtlas Bitmap texture atlas of the armature.
		 *  @return Created animation with wrapped armature. */		
		public function buildAnimation(id:String, textureAtlas:TextureAtlas):DBAnimation
		{
			if(_singleton != this)
				return _singleton.buildAnimation(id, textureAtlas);
			
			var data:DragonBonesData;
			if(id in _dbData)
				data = _dbData[id];
			
			CONFIG::debug {
				if (!data)
					Log.error("Dragon bones data {0} is not found.", id);
			};
			
			_factory.addSkeletonData(data, id);
			_factory.addTextureAtlas(textureAtlas, id);
			
			var armature:Armature = _factory.buildArmature(id);
			var aniamation:DBAnimation = new DBAnimation(armature);
			_animations[id] = aniamation;
			
			return aniamation;
		}
		
		/** Register dragon bones skeletones. This method calls after creation of the dragon bones bundle. */
		protected function regDranonBonesSkeletons():void { }
		
		/** Register Dragon Bones json for loading.
		 *
		 *  @param id Unique identifier of the loader. Use the same name as armature in draon bones tool.
		 *  @param path Path to the json file.
		 *  @param autoScale Specifies whether use autoscale algorithm. Based on design size and stage size texture will be 
		 * 		   proportionally scale to stage size. E.g. design size is 1024x768 and stage size is 800x600 the formula is
		 * 		   <code>var scale:Number = Math.min(1024/800, 768/600);</code></br> 
		 * 		   Calculated scale is 1.28 and all bitmaps scale based on it. */
		protected function regDragonBonesJSON(id:String, path:String, autoScale:Boolean = true):void
		{
			if(_singleton != this)
				return _singleton.regDragonBonesJSON(id, path);
			
			if(!(id in _loaders))
				_loaders[id] = new DBJSONLoader(id, path);
		}
		
		/** Register Dragon Bones xml for loading.
		 *
		 *  @param id Unique identifier of the loader.
		 *  @param path Path to the xml file. Use the same name as armature in draon bones tool.
		 *  @param autoScale Specifies whether use autoscale algorithm. Based on design size and stage size texture will be 
		 * 		   proportionally scale to stage size. E.g. design size is 1024x768 and stage size is 800x600 the formula is
		 * 		   <code>var scale:Number = Math.min(1024/800, 768/600);</code></br> 
		 * 		   Calculated scale is 1.28 and all bitmaps scale based on it. */
		protected function regDragonBonesXML(id:String, path:String, autoScale:Boolean = true):void
		{
			if(_singleton != this)
				return _singleton.regDragonBonesXML(id, path);
			
			if(!(id in _loaders))
				_loaders[id] = new DBXMLLoader(id, path);
		}
		
		/** @private */		
		private function onSkeletonFileLoaded(loader:ITextFileLoader, completer:Completer):void
		{
			loader.build(this);
			loader.release();
			
			completer.complete();
		}
		
		/** @private
		 *  Save skeleton json object in bundle.
		 * 	@param id Unique identifier of the armature.
		 *  @param data Dragon Bones data for armature creation. **/
		firefly_internal function addDragonBonesData(id:String, data:DragonBonesData):void
		{
			if (!(id in _dbData))
				_dbData[id] = data;
		}
	}
}
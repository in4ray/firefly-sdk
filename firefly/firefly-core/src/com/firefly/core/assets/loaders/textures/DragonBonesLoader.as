// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.assets.loaders.textures
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;
	import com.firefly.core.assets.TextureBundle;
	import com.firefly.core.utils.Log;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import com.firefly.core.assets.loaders.ITextureLoader;

	use namespace firefly_internal;
	
	[ExcludeClass]
	/** The loader for loading Dragon Bones based textures. */
	public class DragonBonesLoader implements ITextureLoader
	{
		private var _completer:Completer;
		private var _dbLoader:URLLoader;
		private var _id:String
		private var _path:String;
		private var _autoScale:Boolean;
		private var _data:ByteArray;
		
		/** Constructor.
		 * 
		 *  @param id Unique identifier of the loader.
		 *  @param path Path to the Dragon Bones file.
		 *  @param autoScale Specifies whether use autoscale algorithm. Based on design size and stage size texture will be 
		 * 		   proportionally scale to stage size. E.g. design size is 1024x768 and stage size is 800x600 the formula is
		 * 		   <code>var scale:Number = Math.min(1024/800, 768/600);</code></br> 
		 * 		   Calculated scale is 1.28 and all bitmaps scale based on it.*/
		public function DragonBonesLoader(id:String, path:String, autoScale:Boolean = true)
		{
			this._id = id;
			this._path = path;
			this._autoScale = autoScale;
		}
		
		/** Unique identifier. */
		public function get id():* { return _id; }
		
		/** Loaded Dragon Bones data. */
		public function get data():ByteArray { return _data; }
		
		/** Load Dragon Bones data asynchronously. 
		 *  @return Future object for callback.*/
		public function load(canvas:BitmapData = null, position:Point = null):Future
		{
			_completer = new Completer();
			
			_dbLoader = new URLLoader();
			_dbLoader.dataFormat = URLLoaderDataFormat.BINARY;
			_dbLoader.addEventListener(Event.COMPLETE, onUrlLoaderComplete);
			_dbLoader.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
			_dbLoader.load(new URLRequest(_path));
			
			return _completer.future;
		}
		
		/** Unload loaded data. */	
		public function unload():void
		{
			if (_dbLoader)
			{
				_dbLoader.removeEventListener(Event.COMPLETE, onUrlLoaderComplete);
				_dbLoader.removeEventListener(IOErrorEvent.IO_ERROR, onIoError);
				_dbLoader = null;
			}
			if (_data)
			{
				_data.clear();
				_data = null;
			}
		}
		
		/** Build textures for Dragon Bones.
		 * 	@param visitor Texture bundle to call method of textures creation from byte array.
		 *  @return Future object for callback.*/
		public function build(visitor:TextureBundle):Future
		{
			return visitor.createTextureForDragonBones(_id, _data, _autoScale);
		}
		
		/** @private */		
		private function onIoError(event:IOErrorEvent):void
		{
			Log.error("Loading dragon bones texture IO error: {0}", event.text);
			_completer.complete();
		}
		
		/** @private */		
		private function onUrlLoaderComplete(event:Event):void
		{
			_data = event.target.data;
			_completer.complete();
		}
	}
}
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
	/** The loader for loading ATF asset. */
	public class ATFLoader implements ITextureLoader
	{
		private var _completer:Completer;
		private var _atfLoader:URLLoader;
		private var _path:String;
		private var _id:String
		private var _data:ByteArray;
		
		/** Constructor.
		 *  @param id Unique identifier of the loader.
		 *  @param path Path to the ATF file.*/		
		public function ATFLoader(id:String, path:String)
		{
			this._id = id; 
			this._path = path;
		}
		
		/** Unique identifier. */
		public function get id():* { return _id; }
		
		/** Loaded ATF data. */
		public function get data():ByteArray { return _data; }
		
		/** Load ATF data asynchronously. 
		 *  @return Future object for callback.*/
		public function load(canvas:BitmapData = null, position:Point = null):Future
		{
			_completer = new Completer();
			
			_atfLoader = new URLLoader();
			_atfLoader.dataFormat = URLLoaderDataFormat.BINARY;
			_atfLoader.addEventListener(Event.COMPLETE, onUrlLoaderComplete);
			_atfLoader.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
			_atfLoader.load(new URLRequest(_path));
			
			return _completer.future;
		}
		
		/** Unload loaded data. */	
		public function unload():void
		{
			if (_atfLoader)
			{
				_atfLoader.removeEventListener(Event.COMPLETE, onUrlLoaderComplete);
				_atfLoader.removeEventListener(IOErrorEvent.IO_ERROR, onIoError);
				_atfLoader = null;
			}
			if (_data)
			{
				_data.clear();
				_data = null;
			}	
		}
		
		/** Build texture from the loaded data.
		 * 	@param assetBundle Texture bundle to call method of texture creation from byte array.
		 *  @return Future object for callback.*/
		public function build(assetBundle:TextureBundle):Future
		{
			assetBundle.createTextureFromByteArray(_id, _data);
			
			return null;
		}
		
		/** @private */	
		private function onIoError(event:IOErrorEvent):void
		{
			Log.error("Loading atf texture IO error: {0}", event.text);
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
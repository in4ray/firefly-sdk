// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.assets.loaders
{
	import com.firefly.core.assets.IAssetBundle;
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;
	import com.firefly.core.utils.Log;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/** The basic class for loading json asset. */
	[ExcludeClass]
	public class JSONLoader implements ITextFileLoader
	{
		/** @private */
		protected var _completer:Completer;
		/** @private */
		protected var _id:String
		/** @private */
		protected var _path:String;
		/** @private */
		protected var _autoScale:Boolean;
		/** @private */
		protected var _jsonLoader:URLLoader;
		/** @private */
		protected var _json:String;
		
		/** Constructor.
		 * 
		 *  @param id Unique identifier of the loader.
		 *  @param path Path to the json file. 
		 *  @param autoScale Specifies whether use autoscale algorithm. Based on design size and stage size xml will be 
		 * 		   proportionally adjusted to stage size. E.g. design size is 1024x768 and stage size is 800x600 the formula is
		 * 		   <code>var scale:Number = Math.min(1024/800, 768/600);</code></br> 
		 * 		   Calculated scale is 1.28 and textures described in xml scale based on it. */	
		public function JSONLoader(id:String, path:String, autoScale:Boolean = true)
		{
			this._id = id;
			this._path = path;
			this._autoScale = autoScale;
		}
		
		/** @inheritDoc */
		public function get id():* { return _id; }
		
		/** Loaded json string. */
		public function get json():String { return _json; }
		
		/** @inheritDoc */
		public function load():Future
		{
			_completer = new Completer();
			
			_jsonLoader = new URLLoader();
			_jsonLoader.addEventListener(Event.COMPLETE, onJSONLoadingComplete);
			_jsonLoader.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
			_jsonLoader.load(new URLRequest(_path));
			
			return _completer.future;
		}
		
		/** @inheritDoc */
		public function release():void
		{
			if (_jsonLoader)
			{
				_jsonLoader.removeEventListener(Event.COMPLETE, onJSONLoadingComplete);
				_jsonLoader.removeEventListener(IOErrorEvent.IO_ERROR, onIoError);	
				_jsonLoader = null;
			}
			
			_json = null;
		}
		
		/** @inheritDoc */
		public function build(assetBundle:IAssetBundle):Future { return null; }
		
		/** @private */
		protected function onIoError(event:IOErrorEvent):void
		{
			Log.error("Loading json IO error: {0}", event.text);
			_completer.complete();
		}
		
		/** @private */
		protected function onJSONLoadingComplete(event:Event):void
		{
			_json = _jsonLoader.data;
		}
	}
}
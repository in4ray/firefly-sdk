// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.assets.loaders.audio
{
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;
	import com.firefly.core.utils.Log;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import com.firefly.core.assets.loaders.IAudioLoader;

	[ExcludeClass]
	/** Loader that loads .mp3/.ogg audio source from file system. */	
	public class AudioLoader implements IAudioLoader
	{
		/** @private */
		private var _completer:Completer;
		/** @private */
		private var _id:String;
		/** @private */
		private var _path:String;
		/** @private */
		private var _byteArray:ByteArray;
		/** @private */
		private var _checkPolicyFile:Boolean;
		/** @private */
		private var _urlLoader:URLLoader;
	
		/** Constructor.
		 *  @param id Unique identifier.
		 *  @param path File path.
		 *  @param checkPolicyFile Specifies whether the application should attempt to download a URL 
		 * 		   policy file from the loaded object's server before beginning to load the object itself. */		
		public function AudioLoader(id:String, path:String, checkPolicyFile:Boolean = false)
		{
			this._id = id; 
			this._path = path;
			this._checkPolicyFile = checkPolicyFile;
		}
		
		/** @inheritDoc */
		public function get id():* { return _id; }
		
		/** Audio source ByteArray data. */		
		public function get data():* { return _byteArray; }
		
		/** @inheritDoc */
		public function load():Future
		{
			_completer = new Completer();
			
			_urlLoader = new URLLoader();
			_urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			_urlLoader.addEventListener(Event.COMPLETE, onUrlLoaderComplete);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
			_urlLoader.load(new URLRequest(_path));
			
			return _completer.future;
		}
		
		/** @inheritDoc */
		public function release():void
		{
			if (_byteArray)
				_byteArray = null;
		}
		
		/** @private */		
		private function onIoError(event:IOErrorEvent):void
		{
			Log.error("Loading audio IO error: {0}", event.text);
			_completer.complete();
		}
		
		/** @private */		
		private function onUrlLoaderComplete(event:Event):void
		{
			_byteArray = _urlLoader.data;
			_completer.complete();
		}
	}
}
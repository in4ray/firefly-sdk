package com.firefly.core.audio.loaders
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

	public class AudioLoader implements IAudioLoader
	{
		private var _completer:Completer;
		private var _id:String;
		private var _path:String;
		private var _byteArray:ByteArray;
		private var _checkPolicyFile:Boolean;
		private var _urlLoader:URLLoader;
		
		public function AudioLoader(id:String, path:String, checkPolicyFile:Boolean = false)
		{
			this._id = id; 
			this._path = path;
			this._checkPolicyFile = checkPolicyFile;
		}
		
		/** Unique identifier. */
		public function get id():*
		{
			return _id;
		}
		
		public function get data():*
		{
			return _byteArray;
		}
		
		/** Load sound data asynchronously. 
		 *  @return Future object for callback.*/
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
		
		/** Release loaded data. */	
		public function release():void
		{
			if (_byteArray)
				_byteArray = null;
		}
		
		/** @private */		
		private function onIoError(event:IOErrorEvent):void
		{
			Log.error("Loading sound IO error: {0}", event.text);
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
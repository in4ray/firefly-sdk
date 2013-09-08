package com.firefly.core.audio.loaders
{
	import com.firefly.core.async.Future;
	
	import flash.media.Sound;
	import flash.utils.ByteArray;
	
	import avmplus.getQualifiedClassName;

	public class EmbededAudioLoader implements IAudioLoader
	{
		private var _byteArray:ByteArray;
		private var _source:Class;
		
		public function EmbededAudioLoader(source:Class)
		{
			_source = source;
		}
		
		public function get data():ByteArray
		{
			return _byteArray;
		}
		
		public function get id():String
		{
			return getQualifiedClassName(_source);
		}
		
		public function load():Future
		{
			var sound:* = new _source();
			
			if(sound is ByteArray)
			{
				_byteArray = sound as ByteArray;
			}
			else if(sound is Sound)
			{
				_byteArray = new ByteArray();
				(sound as Sound).extract(_byteArray, (sound as Sound).bytesTotal);
			}
			
			return Future.nextFrame();
		}
		
		public function release():void
		{
			_byteArray = null;
		}
	}
}
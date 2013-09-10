package com.firefly.core.audio.loaders
{
	import com.firefly.core.async.Future;
	
	import flash.media.Sound;
	import flash.utils.ByteArray;
	
	import avmplus.getQualifiedClassName;

	public class EmbededAudioLoader implements IAudioLoader
	{
		private var _data:*;
		private var _source:Class;
		
		public function EmbededAudioLoader(source:Class)
		{
			_source = source;
		}
		
		public function get data():*
		{
			return _data;
		}
		
		public function get id():*
		{
			return _source;
		}
		
		public function load():Future
		{
			var sound:* = new _source();
			
			if(sound is ByteArray)
			{
				_data = sound as ByteArray;
			}
			else if(sound is Sound)
			{
				_data = sound as Sound;
			}
			
			return Future.nextFrame();
		}
		
		public function release():void
		{
			_data = null;
		}
	}
}
// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.audio
{
	import com.firefly.core.Firefly;
	import com.firefly.core.firefly_internal;
	import com.in4ray.audio.AudioInterface;
	
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import flash.utils.getQualifiedClassName;

	use namespace firefly_internal;

	[ExcludeClass]
	/** Audio class fo playing sound effects on android OS. */	
	public class SFXAndroid implements IAudio
	{
		private static const _cache:Dictionary = new Dictionary();
		protected static var _audio:AudioInterface;
		
		private var _streamID:int;
		protected var _soundID:int;
		protected var _loopTimer:Timer;
		protected var _length:Number;
		protected var _loop:int;
		protected var _volume:Number=1;
		protected var _sourceId:String;
		
		/** Constructor. */		
		public function SFXAndroid()
		{
			if(!_audio)
				_audio = new AudioInterface(10);
			
			addToMixer();
		}
		
		/** @inheritDoc */		
		public function get volume():Number { return _volume; }
		public function set volume(value:Number):void
		{
			_volume = value;
			update();
		}
		
		/** @inheritDoc */		
		public function load(sourceId:String, source:*):void
		{
			_sourceId = sourceId;
			
			if(!_cache[_sourceId])
			{
				_soundID = _audio.loadSound(getSoundPath(source));
				_cache[_sourceId] = _soundID;
			}
			else
			{
				_soundID = _cache[_sourceId];
				
				if(source is ByteArray)
				{
					(source as ByteArray).position = 0;
					var sound:Sound = new Sound();
					sound.loadCompressedDataFromByteArray(source, source.bytesAvailable);
					_length = sound.length;
				}
				else if (source is Sound)
				{
					_length = (source as Sound).length;
				}
			}
		}

		/** @inheritDoc */
		public function play(loop:int = 0, volume:Number = 1):void
		{
			_volume = volume;
			_loop = loop;
			
			stop();
			
			if(_volume > 0)
			{
				_streamID = _audio.playSound(_soundID, getActualVolume(), 1, 0, 1);
				if(loop)
				{
					if(!_loopTimer)
					{
						_loopTimer = new Timer(_length, loop);
						_loopTimer.addEventListener(TimerEvent.TIMER, onTimer);
					}
					_loopTimer.start();
				}
			}
		}
		
		/** @inheritDoc */		
		public function update():void
		{
			_audio.setSoundVolume(_soundID, getActualVolume());
		}
		
		/** @inheritDoc */
		public function stop():void
		{
			if(_streamID > 0)
				_audio.stopSound(_streamID);
			_streamID = 0;
			if(_loopTimer)
				_loopTimer.stop();
		}
		
		/** @inheritDoc */
		public function unload():void
		{
			stop();
			_audio.unloadSound(_soundID);
		}
		
		/** @inheritDoc */		
		public function dispose():void
		{
			Firefly.current.audioMixer.removeSFX(this);
		}
		
		/** @private */		
		protected function addToMixer():void
		{
			Firefly.current.audioMixer.addSFX(this);
		}
		
		/** @private */
		protected function onTimer(event:TimerEvent):void
		{
			_audio.stopSound(_streamID);
			_streamID = _audio.playSound(_soundID, getActualVolume(), 1, 0, 1);
		}
		
		/** @private */
		protected function getSoundPath(source:ByteArray):String
		{
			var fileStream:FileStream = new FileStream();
			var file:File;
			try
			{
				var path:String = File.applicationStorageDirectory.url + "sounds/" + _sourceId;
				file = new File(path);
				if(!file.exists)
				{
					fileStream.open(file, FileMode.WRITE);
					fileStream.writeBytes(source);
				}
			}
			catch(err:Error)
			{
				trace(err.getStackTrace());
			}
			finally 
			{
				fileStream.close();
			}
			
			return file.nativePath;
		}
		
		/** @private */
		protected function getActualVolume():Number
		{
			return Math.min(Firefly.current.audioMixer.sfxVolume, _volume);
		}
	}
}
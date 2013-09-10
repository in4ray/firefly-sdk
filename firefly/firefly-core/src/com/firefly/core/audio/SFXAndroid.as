
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
	public class SFXAndroid implements IAudio
	{
		private static const cache:Dictionary = new Dictionary();
		
		private var streamID:int;
		protected var soundID:int;
		protected var loopTimer:Timer;
		
		protected static var audio:AudioInterface;
		
		public function SFXAndroid()
		{
			if(!audio)
				audio = new AudioInterface(1);
			
			addToMixer();
		}
		
		protected function addToMixer():void
		{
			Firefly.current.audioMixer.addSFX(this);
		}
		
		public function load(source:*):void
		{
			var soundFileNameame:String = getSoundFileName(source);
			
			if(!cache[soundFileNameame])
			{
				soundID = audio.loadSound(getSoundPath(source));
				cache[soundFileNameame] = soundID;
			}
			else
			{
				soundID = cache[soundFileNameame];
				
				if(source is ByteArray)
				{
					(source as ByteArray).position = 0;
					var sound:Sound = new Sound();
					sound.loadCompressedDataFromByteArray(source, source.bytesAvailable);
					length = sound.length;
				}
				else if (source is Sound)
				{
					length = (source as Sound).length;
				}
			}
		}
		
		protected var length:Number;
		
		protected var _loop:int;

		protected var _volume:Number=1;
		
		public function play(loop:int = 0, volume:Number = 1):void
		{
			_volume = volume;
			_loop = loop;
			
			stop();
			
			if(_volume > 0)
			{
				streamID = audio.playSound(soundID, getActualVolume(), 1, 0, 1);
				if(loop)
				{
					if(!loopTimer)
					{
						loopTimer = new Timer(length, loop);
						loopTimer.addEventListener(TimerEvent.TIMER, onTimer);
					}
					loopTimer.start();
				}
			}
		}
		
		protected function onTimer(event:TimerEvent):void
		{
			audio.stopSound(streamID);
			streamID = audio.playSound(soundID, getActualVolume(), 1, 0, 1);
		}
		
		private var currentIteration:int = 0; 
		
		public function stop():void
		{
			if(streamID > 0)
				audio.stopSound(streamID);
			streamID = 0;
			currentIteration = 0;
			if(loopTimer)
				loopTimer.stop();
		}
		
		public function unload():void
		{
			stop();
			audio.unloadSound(soundID);
		}
		
		protected function getSoundFileName(source:ByteArray):String
		{
			return getQualifiedClassName(source).replace(".", "-").replace("::", "-");
		}
		
		protected function getSoundPath(source:ByteArray):String
		{
			var soundFileName:String = getSoundFileName(source);
			var fileStream:FileStream = new FileStream();
			var file:File;
			try
			{
				var path:String = File.applicationStorageDirectory.url + "sounds/" + soundFileName;
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
		
		public function dispose():void
		{
			Firefly.current.audioMixer.removeSFX(this);
		}
		
		public function update():void
		{
			audio.setSoundVolume(soundID, getActualVolume());
		}
		
		public function get volume():Number
		{
			return _volume;
		}
		
		public function set volume(value:Number):void
		{
			_volume = value;
			update();
		}
		
		protected function getActualVolume():Number
		{
			return Math.min(Firefly.current.audioMixer.sfxVolume, _volume);
		}
		
		public function pause():void
		{
		}
		
		public function resume():void
		{
		}
	}
}
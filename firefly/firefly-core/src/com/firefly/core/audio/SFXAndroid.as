
package com.firefly.core.audio
{
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
		}
		
		public function init(source:ByteArray):void
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

		protected var _userVolume:Number=1;
		
		public function play(loop:int = 0, volume:Number = 1):void
		{
			_userVolume = volume;
			_loop = loop;
			
			stop();
			
			if(_userVolume > 0)
			{
				//streamID = audio.playSound(soundID, Audio.soundVolume.value*_userVolume, 1, 0, 1);
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
		//	streamID = audio.playSound(soundID, Audio.soundVolume.value*_userVolume, 1, 0, 1);
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
		
		public function dispose():void
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
	}
}
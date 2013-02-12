// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.sound
{
	import com.in4ray.audio.AudioInterface;
	import com.in4ray.gaming.events.BindingEvent;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	

	[ExcludeClass]
	public class SoundAndroid implements IAudioEffect
	{
		private var streamID:int;
		protected var soundID:int;
		
		protected static var audio:AudioInterface;
		
		public function SoundAndroid()
		{
			if(!audio)
				audio = new AudioInterface(Audio.maxAudioStreams);
			
			bindVolume();
		}
		
		protected function bindVolume():void
		{
			Audio.soundVolume.bindListener(volumeHandler);
		}
		
		protected function volumeHandler(event:BindingEvent):void
		{
			audio.setSoundVolume(soundID, Audio.soundVolume.value*_userVolume);
		}
		
		public function init(source:*):void
		{
			var soundPath:String = getSoundPath(source);
			soundID = audio.loadSound(soundPath);
		}
		
		protected var _loop:int;

		protected var _userVolume:Number=1;
		
		public function play(loop:int = 0, volume:Number = 1):void
		{
			_userVolume = volume;
			_loop = loop;
			
			stop();
			
			if(_userVolume > 0)
				streamID = audio.playSound(soundID, Audio.soundVolume.value*_userVolume, 1, loop, 1);
		}
		
		public function stop():void
		{
			if(streamID > 0)
				audio.stopSound(streamID);
			streamID = 0;
		}
		
		public function dispose():void
		{
			stop();
			audio.unloadSound(soundID);
		}
		
		protected function getSoundPath(source:ByteArray):String
		{
			var soundFileName:String = getQualifiedClassName(source).replace(".", "-").replace("::", "-");
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
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
	import com.in4ray.gaming.events.BindingEvent;
	
	import flash.utils.ByteArray;
	
	[ExcludeClass]
	public class MusicAndroid extends SoundAndroid
	{
		public function MusicAndroid()
		{
			super();
		}
		
		override protected function bindVolume():void
		{
			Audio.musicVolume.bindListener(volumeHandler);
		}
		
		override protected function volumeHandler(event:BindingEvent):void
		{
			audio.setMusicVolume(soundID, Audio.musicVolume.value*_userVolume);
		}
		
		private static const musics:Vector.<String> = new Vector.<String>(); 
		
		override public function init(source:*):void
		{
			if(source is ByteArray)
			{
				var soundPath:String = getSoundPath(source);
				soundID = musics.indexOf(soundPath) + 1;
				
				if(soundID <= 0)
				{
					musics.push(soundPath);
					soundID = musics.length; 
					audio.loadMusic(soundID, soundPath);
				}
			}
		}
		
		override public function play(loop:int = 0, volume:Number = 1):void
		{
			_loop = loop;
			_userVolume = volume;
			
			stop();
			
			if(_userVolume > 0)
				audio.playMusic(soundID, Audio.musicVolume.value*_userVolume, loop > 0);
		}
		
		override public function stop():void
		{
			if(soundID > 0)
				audio.stopMusic(soundID);
		}
		
		override public function dispose():void
		{
			stop();
			audio.unloadMusic(soundID);
		}
		
	}
}
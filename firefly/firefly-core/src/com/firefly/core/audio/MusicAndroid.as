
package com.firefly.core.audio
{
	import flash.utils.ByteArray;
	
	[ExcludeClass]
	public class MusicAndroid extends SFXAndroid
	{
		public function MusicAndroid()
		{
			super();
		}
		
		private static const musics:Vector.<String> = new Vector.<String>(); 
		
		override public function load(source:ByteArray):void
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
			
			/*if(_userVolume > 0)
				audio.playMusic(soundID, Audio.musicVolume.value*_userVolume, loop > 0);*/
		}
		
		override public function stop():void
		{
			if(soundID > 0)
				audio.stopMusic(soundID);
		}
		
		override public function unload():void
		{
			stop();
			audio.unloadMusic(soundID);
		}
		
	}
}
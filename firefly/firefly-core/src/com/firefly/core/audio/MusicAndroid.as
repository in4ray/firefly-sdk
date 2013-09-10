
package com.firefly.core.audio
{
	import com.firefly.core.Firefly;
	import com.firefly.core.firefly_internal;
	
	import flash.utils.ByteArray;
	
	use namespace firefly_internal;
	
	[ExcludeClass]
	public class MusicAndroid extends SFXAndroid
	{
		public function MusicAndroid()
		{
			super();
		}
		
		override protected function addToMixer():void
		{
			Firefly.current.audioMixer.addMusic(this);
		}
		
		override public function dispose():void 
		{
			Firefly.current.audioMixer.removeMusic(this);
		}
		
		private static const musics:Vector.<String> = new Vector.<String>(); 
		
		override public function load(source:*):void
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
			_volume = volume;
			
			stop();
			
			if(_volume > 0)
				audio.playMusic(soundID, getActualVolume(), loop > 0);
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
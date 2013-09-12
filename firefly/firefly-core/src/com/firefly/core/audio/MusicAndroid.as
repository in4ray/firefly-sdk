
package com.firefly.core.audio
{
	import com.firefly.core.Firefly;
	import com.firefly.core.firefly_internal;
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	use namespace firefly_internal;
	
	[ExcludeClass]
	public class MusicAndroid extends SFXAndroid
	{
		public function MusicAndroid()
		{
			super();
			
			Firefly.current.main.addEventListener(Event.DEACTIVATE, onDeactivate);
			Firefly.current.main.addEventListener(Event.ACTIVATE, onActivate);
		}
		
		override protected function addToMixer():void
		{
			Firefly.current.audioMixer.addMusic(this);
		}
		
		override public function dispose():void 
		{
			unload();
			Firefly.current.audioMixer.removeMusic(this);
			
			Firefly.current.main.removeEventListener(Event.DEACTIVATE, onDeactivate);
			Firefly.current.main.removeEventListener(Event.ACTIVATE, onActivate);
		}
		
		override protected function getActualVolume():Number
		{
			return Math.min(Firefly.current.audioMixer.musicVolume, _volume);
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
			
			paused = false;
		}
		
		override public function unload():void
		{
			stop();
			audio.unloadMusic(soundID);
		}
		
		private var paused:Boolean;

		protected function onActivate(event:Event):void
		{
			if(paused)
			{
				if(_volume > 0)
					audio.playMusic(soundID, getActualVolume(), _loop > 0);
				
				paused = false;
			}
		}
		
		protected function onDeactivate(event:Event):void
		{
			if(audio.isMusicPlaying(soundID))
			{
				stop();
				paused = true;
			}
		}
	}
}
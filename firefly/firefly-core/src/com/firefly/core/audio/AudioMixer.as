package com.firefly.core.audio
{
	import com.firefly.core.Firefly;
	import com.firefly.core.firefly_internal;
	
	import flash.events.Event;
	
	import starling.core.Starling;

	public class AudioMixer
	{
		private var _musics:Vector.<IAudio>;
		private var _sfxs:Vector.<IAudio>;
		private var _musicVolume:Number = 1;
		private var _sfxVolume:Number = 1;
		private var _lastMusicVolume:Number = 1;
		private var _lastSfxVolume:Number = 1;
		
		public function AudioMixer()
		{
			_musics = new Vector.<IAudio>();
			_sfxs = new Vector.<IAudio>();
			Firefly.current.main.addEventListener(Event.DEACTIVATE, onDeactivate);
			Firefly.current.main.addEventListener(Event.ACTIVATE, onActivate);
			
		}
		
		protected function onActivate(event:Event):void
		{
			_musicVolume = _lastMusicVolume;
			_sfxVolume = _lastSfxVolume;
		}
		
		protected function onDeactivate(event:Event):void
		{
			_lastMusicVolume = _musicVolume;
			_lastSfxVolume = _sfxVolume;
			_musicVolume = _sfxVolume = 0;
		}

		public function get musicVolume():Number
		{
			return _musicVolume;
		}

		public function set musicVolume(value:Number):void
		{
			_musicVolume = value;
			
			for each (var audio:IAudio in _musics) 
			{
				audio.update();
			}
		}
		
		public function get sfxVolume():Number
		{
			return _sfxVolume;
		}

		public function set sfxVolume(value:Number):void
		{
			_sfxVolume = value;
			
			for each (var audio:IAudio in _sfxs) 
			{
				audio.update();
			}
		}
		
		firefly_internal function addMusic(audio:IAudio):void
		{
			_musics.push(audio);
		}
		
		firefly_internal function removeMusic(audio:IAudio):void
		{
			var index:int = _musics.indexOf(audio);
			if(index > -1)
				_musics.splice(index, 1);
		}
		
		firefly_internal function addSFX(audio:IAudio):void
		{
			_sfxs.push(audio);
		}
		
		firefly_internal function removeSFX(audio:IAudio):void
		{
			var index:int = _sfxs.indexOf(audio);
			if(index > -1)
				_sfxs.splice(index, 1);
		}
		
		public function fadeMusic(toValue:Number, duration:Number):void
		{
			Starling.juggler.tween(this, duration, {musicVolume: toValue});
		}
		
		public function fadeSFX(toValue:Number, duration:Number):void
		{
			Starling.juggler.tween(this, duration, {sfxVolume: toValue});
		}
		
		public function fadeAudio(audio:IAudio, toValue:Number, duration:Number):void
		{
			Starling.juggler.tween(audio, duration, {volume: toValue});	
		}
	}
}
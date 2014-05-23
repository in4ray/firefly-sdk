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
	
	import flash.events.Event;
	
	import starling.core.Starling;

	/** Class that controlls audio instances. */	
	public class AudioMixer
	{
		private var _musics:Vector.<IAudio>;
		private var _sfxs:Vector.<IAudio>;
		private var _musicVolume:Number = 1;
		private var _sfxVolume:Number = 1;
		private var _lastMusicVolume:Number = 1;
		private var _lastSfxVolume:Number = 1;
		
		/** Constructor. */
		public function AudioMixer()
		{
			_musics = new Vector.<IAudio>();
			_sfxs = new Vector.<IAudio>();
			Firefly.current.main.addEventListener(Event.DEACTIVATE, onDeactivate);
			Firefly.current.main.addEventListener(Event.ACTIVATE, onActivate);
			
		}

		/** Volume for music instances. */		
		public function get musicVolume():Number { return _musicVolume; }
		public function set musicVolume(value:Number):void
		{
			_musicVolume = value;
			
			for each (var audio:IAudio in _musics) 
			{
				audio.update();
			}
		}
		
		/** Volume for sound effect instances. */	
		public function get sfxVolume():Number { return _sfxVolume; }
		public function set sfxVolume(value:Number):void
		{
			_sfxVolume = value;
			
			for each (var audio:IAudio in _sfxs) 
			{
				audio.update();
			}
		}
		
		/** Fade all musics to specified volume with specified duration.
		 *  @param toVolume Target music volume.
		 *  @param duration Duration of fade effect in sec. */		
		public function fadeMusic(toVolume:Number, duration:Number):void
		{
			Firefly.current.juggler.tween(this, duration, {musicVolume: toVolume});
		}
		
		/** Fade all sound effects to specified volume with specified duration.
		 *  @param toVolume Target effect volume.
		 *  @param duration Duration of fade effect in sec. */		
		public function fadeSFX(toVolume:Number, duration:Number):void
		{
			Firefly.current.juggler.tween(this, duration, {sfxVolume: toVolume});
		}
		
		/** Fade specified audio to specified volume with specified duration.
		 *  @param audio Target audio instance to be faded.
		 *  @param toVolume Target audio volume.
		 *  @param duration Duration of fade effect in sec. */	
		public function fadeAudio(audio:IAudio, toVolume:Number, duration:Number):void
		{
			Firefly.current.juggler.tween(audio, duration, {volume: toVolume});	
		}
		
		/** @private
		 *  Add music for managing
		 *  @param audio Music instance */		
		firefly_internal function addMusic(audio:IAudio):void
		{
			_musics.push(audio);
		}
		
		/** @private
		 *  Remove music from managing
		 *  @param audio Music instance */	
		firefly_internal function removeMusic(audio:IAudio):void
		{
			var index:int = _musics.indexOf(audio);
			if(index > -1)
				_musics.splice(index, 1);
		}
		
		/** @private
		 *  Add sound effect for managing
		 *  @param audio Sound effect instance */	
		firefly_internal function addSFX(audio:IAudio):void
		{
			_sfxs.push(audio);
		}
		
		/** @private
		 *  Remove sound effect from managing
		 *  @param audio Sound effect instance */	
		firefly_internal function removeSFX(audio:IAudio):void
		{
			var index:int = _sfxs.indexOf(audio);
			if(index > -1)
				_sfxs.splice(index, 1);
		}
		
		/** @private */		
		protected function onActivate(event:Event):void
		{
			_musicVolume = _lastMusicVolume;
			_sfxVolume = _lastSfxVolume;
		}
		
		/** @private */
		protected function onDeactivate(event:Event):void
		{
			_lastMusicVolume = _musicVolume;
			_lastSfxVolume = _sfxVolume;
			_musicVolume = _sfxVolume = 0;
		}
	}
}
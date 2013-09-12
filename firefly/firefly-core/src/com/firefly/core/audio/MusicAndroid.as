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
	import flash.utils.ByteArray;
	
	use namespace firefly_internal;
	
	[ExcludeClass]
	/** Audio class fo playing music on android OS. */	
	public class MusicAndroid extends SFXAndroid
	{
		private static const _musics:Vector.<String> = new Vector.<String>();
		
		private var _paused:Boolean;
		
		/** Constructor. */		
		public function MusicAndroid()
		{
			super();
			
			Firefly.current.main.addEventListener(Event.DEACTIVATE, onDeactivate);
			Firefly.current.main.addEventListener(Event.ACTIVATE, onActivate);
		}
		
		/** @inheritDoc */	
		override public function load(source:*):void
		{
			if(source is ByteArray)
			{
				var soundPath:String = getSoundPath(source);
				_soundID = _musics.indexOf(soundPath) + 1;
				
				if(_soundID <= 0)
				{
					_musics.push(soundPath);
					_soundID = _musics.length; 
					_audio.loadMusic(_soundID, soundPath);
				}
			}
		}
		
		/** @inheritDoc */	
		override public function play(loop:int = 0, volume:Number = 1):void
		{
			_loop = loop;
			_volume = volume;
			
			stop();
			
			if(_volume > 0)
				_audio.playMusic(_soundID, getActualVolume(), loop > 0);
		}
		
		/** @inheritDoc */	
		override public function stop():void
		{
			if(_soundID > 0)
				_audio.stopMusic(_soundID);
			
			_paused = false;
		}
		
		/** @inheritDoc */	
		override public function unload():void
		{
			stop();
			_audio.unloadMusic(_soundID);
		}
		
		/** @inheritDoc */	
		override public function dispose():void 
		{
			unload();
			Firefly.current.audioMixer.removeMusic(this);
			
			Firefly.current.main.removeEventListener(Event.DEACTIVATE, onDeactivate);
			Firefly.current.main.removeEventListener(Event.ACTIVATE, onActivate);
		}
		
		/** @inheritDoc */		
		override protected function addToMixer():void
		{
			Firefly.current.audioMixer.addMusic(this);
		}
		
		/** @inheritDoc */	
		override protected function getActualVolume():Number
		{
			return Math.min(Firefly.current.audioMixer.musicVolume, _volume);
		}
		
		/** @private */	
		protected function onActivate(event:Event):void
		{
			if(_paused)
			{
				if(_volume > 0)
					_audio.playMusic(_soundID, getActualVolume(), _loop > 0);
				
				_paused = false;
			}
		}
		
		/** @private */
		protected function onDeactivate(event:Event):void
		{
			if(_audio.isMusicPlaying(_soundID))
			{
				stop();
				_paused = true;
			}
		}
	}
}
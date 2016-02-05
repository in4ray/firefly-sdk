// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
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
	import flash.media.SoundTransform;

	use namespace firefly_internal;
	
	[ExcludeClass]
	/** Audio class fo playing music on iOs and web. */	
	public class MusicDefault extends SFXDefault
	{
		/** @private */
		private var _paused:Boolean;
		
		/** Constructor. */		
		public function MusicDefault()
		{
			super();
			
			Firefly.current.main.addEventListener(Event.DEACTIVATE, onDeactivate);
			Firefly.current.main.addEventListener(Event.ACTIVATE, onActivate);
		}
		
		/** @inheritDoc */
		override public function stop():void
		{
			super.stop();
			_paused = false;
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
				{
					_channel = _sound.play(0, _loop);
					_channel.soundTransform = new SoundTransform(getActualVolume());
				}
				
				_paused = false;
			}
		}
		
		/** @private */
		protected function onDeactivate(event:Event):void
		{
			if(_channel)
			{
				stop();
				_paused = true;
			}
		}
	}
}
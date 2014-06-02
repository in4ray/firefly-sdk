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
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.ByteArray;
	
	use namespace firefly_internal;
	
	[ExcludeClass]
	/** Audio class fo playing sound effects on android iOS and web. */	
	public class SFXDefault implements IAudio
	{
		/** @private */
		protected var _sound:Sound;
		/** @private */
		protected var _channel:SoundChannel;
		/** @private */
		protected var _volume:Number;
		/** @private */
		protected var _loop:int;
		
		/** Constructor. */	
		public function SFXDefault()
		{
			addToMixer();
		}
		
		/** @inheritDoc */		
		public function get volume():Number { return _volume; }
		public function set volume(value:Number):void
		{
			_volume = value;
			update();
		}
		
		/** @inheritDoc */		
		public function load(sourceId:String, source:*):void
		{
			stop();
			if(source is ByteArray)
			{
				(source as ByteArray).position = 0;
				_sound = new Sound();
				_sound.loadCompressedDataFromByteArray(source, source.bytesAvailable);
			}
			else if (source is Sound)
			{
				_sound = source as Sound;
			}
		}
		
		/** @inheritDoc */		
		public function play(loop:int = 0, volume:Number = 1):void
		{
			_loop = loop;
			_volume = volume;
			stop();
			
			if(_volume > 0)
			{
				_channel = _sound.play(0, loop);
				_channel.soundTransform = new SoundTransform(getActualVolume());
			}
		}
		
		/** @inheritDoc */	
		public function update():void
		{
			if(_channel)
				_channel.soundTransform = new SoundTransform(getActualVolume());
		}
		
		/** @inheritDoc */		
		public function stop():void
		{
			if(_channel)
				_channel.stop();
			_channel = null;
		}
		
		/** @inheritDoc */		
		public function unload():void
		{
			stop();
			_sound = null;
		}
		
		/** @inheritDoc */		
		public function dispose():void
		{
			unload();
			Firefly.current.audioMixer.removeSFX(this);
		}
		
		/** @private */	
		protected function addToMixer():void
		{
			Firefly.current.audioMixer.addSFX(this);
		}
		
		/** @private */	
		protected function getActualVolume():Number
		{
			return Math.min(Firefly.current.audioMixer.sfxVolume, _volume);
		}
	}
}
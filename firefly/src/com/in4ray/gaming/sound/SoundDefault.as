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
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.ByteArray;
	
	[ExcludeClass]
	public class SoundDefault implements IAudioEffect
	{
		protected var sound:Sound;
		protected var channel:SoundChannel;

		public function SoundDefault()
		{
			bindVolume();
		}
		
		protected function bindVolume():void
		{
			Audio.soundVolume.bindListener(volumeHandler);
		}
		
		protected function volumeHandler(event:BindingEvent):void
		{
			if(channel)
				channel.soundTransform = new SoundTransform(_userVolume*(event.data as Number));
		}
			
		public function init(source:*):void
		{
			stop();
			if(source is ByteArray)
			{
				(source as ByteArray).position = 0;
				sound = new Sound();
				sound.loadCompressedDataFromByteArray(source, source.bytesAvailable);
			}
			else if (source is Sound)
			{
				sound = source as Sound;
			}
		}
		
		protected var _userVolume:Number;
		
		protected var _loop:int;
		
		public function play(loop:int = 0, volume:Number = 1):void
		{
			_loop = loop;
			_userVolume = volume;
			stop();
			
			if(_userVolume > 0)
			{
				channel = sound.play(0, loop);
				channel.soundTransform = new SoundTransform(Audio.soundVolume.value*_userVolume);
			}
		}
		
		public function stop():void
		{
			if(channel)
				channel.stop();
			channel = null;
		}
		
		public function dispose():void
		{
			stop();
			sound = null;
		}
	}
}
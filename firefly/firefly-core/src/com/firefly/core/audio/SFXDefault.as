
package com.firefly.core.audio
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.ByteArray;
	
	[ExcludeClass]
	public class SFXDefault implements IAudio
	{
		protected var sound:Sound;
		protected var channel:SoundChannel;

		public function SFXDefault()
		{
		}
		
		public function load(source:ByteArray):void
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
				//channel.soundTransform = new SoundTransform(Audio.soundVolume.value*_userVolume);
			}
		}
		
		public function stop():void
		{
			if(channel)
				channel.stop();
			channel = null;
		}
		
		public function unload():void
		{
			stop();
			sound = null;
		}
	}
}
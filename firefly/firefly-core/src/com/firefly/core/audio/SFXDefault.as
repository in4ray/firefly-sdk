
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
	public class SFXDefault implements IAudio
	{
		protected var sound:Sound;
		protected var channel:SoundChannel;

		public function SFXDefault()
		{
			addToMixer();
		}
		
		protected function addToMixer():void
		{
			Firefly.current.audioMixer.addSFX(this);
		}
		
		public function load(source:*):void
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
		
		protected var _volume:Number;
		
		protected var _loop:int;
		
		public function play(loop:int = 0, volume:Number = 1):void
		{
			_loop = loop;
			_volume = volume;
			stop();
			
			if(_volume > 0)
			{
				channel = sound.play(0, loop);
				channel.soundTransform = new SoundTransform(getActualVolume());
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
		
		public function dispose():void
		{
			unload();
			Firefly.current.audioMixer.removeSFX(this);
		}
		
		public function update():void
		{
			if(channel)
				channel.soundTransform = new SoundTransform(getActualVolume());
		}
		
		public function get volume():Number
		{
			return _volume;
		}
		
		public function set volume(value:Number):void
		{
			_volume = value;
			update();
		}
		
		protected function getActualVolume():Number
		{
			return Math.min(Firefly.current.audioMixer.sfxVolume, _volume);
		}
	}
}
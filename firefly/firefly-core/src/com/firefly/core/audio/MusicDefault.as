
package com.firefly.core.audio
{
	import flash.media.SoundTransform;

	[ExcludeClass]
	public class MusicDefault extends SFXDefault
	{
		public function MusicDefault()
		{
			super();
		}
		
		override public function play(loop:int = 0, volume:Number = 1):void
		{
			super.play(loop, volume);
			
			/*if(channel)
				channel.soundTransform = new SoundTransform(_userVolume*Audio.musicVolume.value);*/
		}
	}
}
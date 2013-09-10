
package com.firefly.core.audio
{
	import com.firefly.core.Firefly;
	import com.firefly.core.firefly_internal;
	
	import flash.media.SoundTransform;

	use namespace firefly_internal;
	
	[ExcludeClass]
	public class MusicDefault extends SFXDefault
	{
		public function MusicDefault()
		{
			super();
		}
		
		override protected function addToMixer():void
		{
			Firefly.current.audioMixer.addMusic(this);
		}
		
		override public function dispose():void 
		{
			Firefly.current.audioMixer.removeMusic(this);
		}
		
		override public function play(loop:int = 0, volume:Number = 1):void
		{
			super.play(loop, volume);
			
			if(channel)
				channel.soundTransform = new SoundTransform(getActualVolume());
		}
	}
}
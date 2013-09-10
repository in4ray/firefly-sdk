
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
			unload();
			Firefly.current.audioMixer.removeMusic(this);
		}
		
		override protected function getActualVolume():Number
		{
			return Math.min(Firefly.current.audioMixer.musicVolume, _volume);
		}
		
		override public function stop():void
		{
			super.stop();
			paused = false;
		}
		
		private var paused:Boolean;
		override public function pause():void
		{
			if(channel)
			{
				stop();
				paused = true;
			}
		}
		
		override public function resume():void
		{
			if(paused)
			{
				if(_volume > 0)
				{
					channel = sound.play(0, _loop);
					channel.soundTransform = new SoundTransform(getActualVolume());
				}
				
				paused = false;
			}
		}
	}
}
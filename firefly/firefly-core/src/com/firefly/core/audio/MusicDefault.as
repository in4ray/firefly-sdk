
package com.firefly.core.audio
{
	import com.firefly.core.Firefly;
	import com.firefly.core.firefly_internal;
	
	import flash.events.Event;
	import flash.media.SoundTransform;
	

	use namespace firefly_internal;
	
	[ExcludeClass]
	public class MusicDefault extends SFXDefault
	{
		public function MusicDefault()
		{
			super();
			
			Firefly.current.main.addEventListener(Event.DEACTIVATE, onDeactivate);
			Firefly.current.main.addEventListener(Event.ACTIVATE, onActivate);
		}
		
		override protected function addToMixer():void
		{
			Firefly.current.audioMixer.addMusic(this);
		}
		
		override public function dispose():void 
		{
			unload();
			Firefly.current.audioMixer.removeMusic(this);
			
			Firefly.current.main.removeEventListener(Event.DEACTIVATE, onDeactivate);
			Firefly.current.main.removeEventListener(Event.ACTIVATE, onActivate);
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

		protected function onActivate(event:Event):void
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
		
		protected function onDeactivate(event:Event):void
		{
			if(channel)
			{
				stop();
				paused = true;
			}
		}
	}
}
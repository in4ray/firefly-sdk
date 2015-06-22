package com.in4ray.particle.journey.bundles
{
	import com.firefly.core.assets.AudioBundle;
	import com.firefly.core.audio.IAudio;
	
	
	public class AudioBundle extends com.firefly.core.assets.AudioBundle
	{
		public function AudioBundle()
		{
			super();
		}
		
		override protected function regAudio():void
		{
			regEmbededMusic(MenuMusicSwcClass);
			regSFX("click", "../audio/click.mp3");
		}
		
		public function get menuMusic():IAudio { return getAudio(MenuMusicSwcClass) };
		public function get click():IAudio { return getAudio("click") };
	}
}
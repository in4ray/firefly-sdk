package com.in4ray.particle.journey.audio
{
	import com.firefly.core.audio.AudioBundle;
	import com.firefly.core.audio.IAudio;
	
	import starling.textures.Texture;
	
	public class GameAudioBundle extends AudioBundle
	{
		public function GameAudioBundle()
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
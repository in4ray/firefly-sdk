package test.audio.helpers
{
	import com.firefly.core.audio.AudioBundle;
	import com.firefly.core.audio.IAudio;
	
	public class GameAudioBundle extends AudioBundle
	{
		public function GameAudioBundle()
		{
			super();
		}
		
		override protected function regAudio():void
		{
			regSFX("click", "../audio/click.mp3", 2);
			regMusic("menuMusic", "../audio/MenuMusic.ogg");
			regEmbededMusic(MenuMusicSwcClass);
		}
		
		public function get click():IAudio { return getAudio("click") };
		public function get menuMusic():IAudio { return getAudio("menuMusic") };
		public function get embededMenuMusic():IAudio { return getAudio(MenuMusicSwcClass) };
	}
}
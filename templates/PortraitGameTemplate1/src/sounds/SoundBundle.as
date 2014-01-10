package sounds
{
	import com.firefly.core.Firefly;
	import com.firefly.core.audio.AudioBundle;
	import com.firefly.core.audio.IAudio;
	import com.firefly.core.consts.SystemType;
	
	public class SoundBundle extends AudioBundle
	{
		override protected function regAudio():void
		{
			if(Firefly.current.systemType == SystemType.ANDROID)
				regMusic("menu_music", "/sounds/menu_music.ogg");
			else
				regEmbededMusic(MenuMusicSwcClass);
			
			regSFX("click", "/sounds/click.mp3");
		}
		
		public function get click():IAudio
		{
			return getAudio("click"); 
		}
		
		public function get menuMusic():IAudio
		{
			if(Firefly.current.systemType == SystemType.ANDROID)
				return getAudio("menu_music");
			else
				return getAudio(MenuMusicSwcClass);
		}
	}
}
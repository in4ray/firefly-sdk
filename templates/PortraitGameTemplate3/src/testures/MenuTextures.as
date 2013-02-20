package testures
{
	import com.in4ray.gaming.consts.TextureConsts;
	import com.in4ray.gaming.texturers.TextureBundle;
	
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	import textures.ExitDialogBackground;
	import textures.GameName;
	import textures.LevelBackground;
	import textures.LevelLock;
	import textures.MenuBackground;
	import textures.buttons.BackDownButton;
	import textures.buttons.BackUpButton;
	import textures.buttons.CloseDownButton;
	import textures.buttons.CloseUpButton;
	import textures.buttons.ConfirmDownButton;
	import textures.buttons.ConfirmUpButton;
	import textures.buttons.CreditsDownButton;
	import textures.buttons.CreditsUpButton;
	import textures.buttons.ExitDownRedButton;
	import textures.buttons.ExitUpRedButton;
	import textures.buttons.FacebookDownButton;
	import textures.buttons.FacebookUpButton;
	import textures.buttons.MoreDownButton;
	import textures.buttons.MoreUpButton;
	import textures.buttons.PauseDownButton;
	import textures.buttons.PauseUpButton;
	import textures.buttons.PlayDownButton;
	import textures.buttons.PlayUpButton;
	import textures.buttons.SoundOffDownButton;
	import textures.buttons.SoundOffUpButton;
	import textures.buttons.SoundOnDownButton;
	import textures.buttons.SoundOnUpButton;
	import textures.buttons.TwitterDownButton;
	import textures.buttons.TwitterUpButton;
	
	public class MenuTextures extends TextureBundle
	{
		public function MenuTextures()
		{
			super();
			
			composerWidth = TextureConsts.MAX_WIDTH;
			composerHeight = TextureConsts.MAX_HEIGHT;
		}
		
		override protected function registerTextures():void
		{
			registerTexture(PlayUpButton);
			registerTexture(PlayDownButton);
			
			registerTexture(BackUpButton);
			registerTexture(BackDownButton);
			registerTexture(CloseUpButton);
			registerTexture(CloseDownButton);
			registerTexture(TwitterUpButton);
			registerTexture(TwitterDownButton);
			registerTexture(FacebookUpButton);
			registerTexture(FacebookDownButton);
			registerTexture(CreditsUpButton);
			registerTexture(CreditsDownButton);
			registerTexture(MoreUpButton);
			registerTexture(MoreDownButton);
			registerTexture(SoundOnUpButton);
			registerTexture(SoundOnDownButton);
			registerTexture(SoundOffUpButton);
			registerTexture(SoundOffDownButton);
			
			registerTexture(ExitUpRedButton);
			registerTexture(ExitDownRedButton);
			registerTexture(ConfirmUpButton);
			registerTexture(ConfirmDownButton);
			
			registerTexture(LevelBackground);
			registerTexture(LevelLock);
			registerTexture(ExitDialogBackground);
			
			registerTexture(GameName);
			registerTexture(MenuBackground, HAlign.CENTER, VAlign.BOTTOM);
		}
		
		public function get playUpButton():Texture
		{
			return getTexture(PlayUpButton);
		}
		
		public function get playDownButton():Texture
		{
			return getTexture(PlayDownButton);
		}
		
		public function get backUpButton():Texture
		{
			return getTexture(BackUpButton);
		}
		
		public function get backDownButton():Texture
		{
			return getTexture(BackDownButton);
		}
		
		public function get closeUpButton():Texture
		{
			return getTexture(CloseUpButton);
		}
		
		public function get closeDownButton():Texture
		{
			return getTexture(CloseDownButton);
		}
		
		public function get twitterUpButton():Texture
		{
			return getTexture(TwitterUpButton);
		}
		
		public function get twitterDownButton():Texture
		{
			return getTexture(TwitterDownButton);
		}
		
		public function get facebookUpButton():Texture
		{
			return getTexture(FacebookUpButton);
		}
		
		public function get facebookDownButton():Texture
		{
			return getTexture(FacebookDownButton);
		}
		
		public function get creditsUpButton():Texture
		{
			return getTexture(CreditsUpButton);
		}
		
		public function get creditsDownButton():Texture
		{
			return getTexture(CreditsDownButton);
		}
		
		public function get moreUpButton():Texture
		{
			return getTexture(MoreUpButton);
		}
		
		public function get moreDownButton():Texture
		{
			return getTexture(MoreDownButton);
		}
		
		public function get soundOnUpButton():Texture
		{
			return getTexture(SoundOnUpButton);
		}
		
		public function get soundOnDownButton():Texture
		{
			return getTexture(SoundOnDownButton);
		}
		
		public function get soundOffUpButton():Texture
		{
			return getTexture(SoundOffUpButton);
		}
		
		public function get soundOffDownButton():Texture
		{
			return getTexture(SoundOffDownButton);
		}
		
		public function get exitDialog():Texture
		{
			return getTexture(ExitDialogBackground);
		}
		
		public function get confirmUpButton():Texture
		{
			return getTexture(ConfirmUpButton);
		}
		
		public function get confirmDownButton():Texture
		{
			return getTexture(ConfirmDownButton);
		}
		
		public function get exitUpRedButton():Texture
		{
			return getTexture(ExitUpRedButton);
		}
		
		public function get exitDownRedButton():Texture
		{
			return getTexture(ExitDownRedButton);
		}
		
		public function get gameName():Texture
		{
			return getTexture(GameName);
		}
		
		public function get menuBackground():Texture
		{
			return getTexture(MenuBackground);
		}
		
		public function get levelBackground():Texture
		{
			return getTexture(LevelBackground);
		}
		
		public function get levelLock():Texture
		{
			return getTexture(LevelLock);
		}
	}
}



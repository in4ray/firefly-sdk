package textures
{
	import com.firefly.core.textures.TextureBundle;
	
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
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
		}
		
		override protected function regTextures():void
		{
			regFXGTexture(PlayUpButton);
			regFXGTexture(PlayDownButton);
			
			regFXGTexture(BackUpButton);
			regFXGTexture(BackDownButton);
			regFXGTexture(CloseUpButton);
			regFXGTexture(CloseDownButton);
			regFXGTexture(TwitterUpButton);
			regFXGTexture(TwitterDownButton);
			regFXGTexture(FacebookUpButton);
			regFXGTexture(FacebookDownButton);
			regFXGTexture(CreditsUpButton);
			regFXGTexture(CreditsDownButton);
			regFXGTexture(MoreUpButton);
			regFXGTexture(MoreDownButton);
			regFXGTexture(SoundOnUpButton);
			regFXGTexture(SoundOnDownButton);
			regFXGTexture(SoundOffUpButton);
			regFXGTexture(SoundOffDownButton);
			
			regFXGTexture(ExitUpRedButton);
			regFXGTexture(ExitDownRedButton);
			regFXGTexture(ConfirmUpButton);
			regFXGTexture(ConfirmDownButton);
			
			regFXGTexture(LevelBackground);
			regFXGTexture(LevelLock);
			regFXGTexture(ExitDialogBackground);
			
			regFXGTexture(GameName);
			regFXGTexture(MenuBackground, true, false, HAlign.CENTER, VAlign.BOTTOM);
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



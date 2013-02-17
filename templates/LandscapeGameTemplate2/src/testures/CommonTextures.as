package testures
{
	import com.in4ray.gaming.consts.TextureConsts;
	import com.in4ray.gaming.texturers.TextureBundle;
	
	import starling.textures.Texture;
	
	import textures.buttons.ContinueDownButton;
	import textures.buttons.ContinueUpButton;
	import textures.buttons.MenuDownButton;
	import textures.buttons.MenuUpButton;
	import textures.buttons.PauseDownButton;
	import textures.buttons.PauseUpButton;
	import textures.buttons.RestartDownButton;
	import textures.buttons.RestartUpButton;
	
	public class CommonTextures extends TextureBundle 
	{
		public function CommonTextures()
		{
			super();
			
			composerWidth = TextureConsts.MAX_WIDTH;
			composerHeight = TextureConsts.MAX_HEIGHT;
		}
		
		override protected function registerTextures():void
		{
			registerTexture(ContinueUpButton);
			registerTexture(ContinueDownButton);
			registerTexture(RestartUpButton);
			registerTexture(RestartDownButton);
			registerTexture(MenuUpButton);
			registerTexture(MenuDownButton);
			registerTexture(PauseUpButton);
			registerTexture(PauseDownButton);
		}
		
		public function get menuUpButton():Texture
		{
			return getTexture(MenuUpButton);
		}
		
		public function get menuDownButton():Texture
		{
			return getTexture(MenuDownButton);
		}
		
		public function get continueUpButton():Texture
		{
			return getTexture(ContinueUpButton);
		}
		
		public function get continueDownButton():Texture
		{
			return getTexture(ContinueDownButton);
		}
		
		public function get restartUpButton():Texture
		{
			return getTexture(RestartUpButton);
		}
		
		public function get restartDownButton():Texture
		{
			return getTexture(RestartDownButton);
		}
		
		public function get pauseUpButton():Texture
		{
			return getTexture(PauseUpButton);
		}
		
		public function get pauseDownButton():Texture
		{
			return getTexture(PauseDownButton);
		}
	}
}
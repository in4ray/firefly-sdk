package testures
{
	import com.firefly.core.textures.TextureBundle;
	
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
		}
		
		override protected function regTextures():void
		{
			regFXGTexture(ContinueUpButton);
			regFXGTexture(ContinueDownButton);
			regFXGTexture(RestartUpButton);
			regFXGTexture(RestartDownButton);
			regFXGTexture(MenuUpButton);
			regFXGTexture(MenuDownButton);
			regFXGTexture(PauseUpButton);
			regFXGTexture(PauseDownButton);
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
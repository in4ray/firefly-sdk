package testures
{
	import com.in4ray.gaming.consts.TextureConsts;
	import com.in4ray.gaming.texturers.TextureBundle;
	
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	import textures.MenuBackground;

	public class GameTextures extends TextureBundle
	{
		public function GameTextures()
		{
			super();
			
			composerWidth = TextureConsts.MAX_WIDTH;
			composerHeight = TextureConsts.MAX_HEIGHT;
		}
		
		override protected function registerTextures():void
		{
			registerTexture(MenuBackground, HAlign.CENTER, VAlign.BOTTOM);
		}
		
		public function get background():Texture
		{
			return getTexture(MenuBackground);
		}
	}
}
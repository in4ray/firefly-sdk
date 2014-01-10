package textures
{
	
	import com.firefly.core.textures.TextureBundle;
	
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	

	public class GameTextures extends TextureBundle
	{
		public function GameTextures()
		{
			super();
		}
		
		override protected function regTextures():void
		{
			regFXGTexture(MenuBackground, HAlign.CENTER, VAlign.BOTTOM);
		}
		
		public function get background():Texture
		{
			return getTexture(MenuBackground);
		}
	}
}
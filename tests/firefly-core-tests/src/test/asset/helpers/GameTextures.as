package test.asset.helpers
{
	import com.firefly.core.textures.TextureBundle;
	
	import starling.textures.Texture;
	
	import textures.GameName;
	
	public class GameTextures extends TextureBundle
	{
		public function GameTextures()
		{
			super();
		}
		
		override protected function regTextures():void
		{
			regFXGTexture(GameName);
		}
		
		public function get gameName():Texture { return getTexture(GameName) };
	}
}
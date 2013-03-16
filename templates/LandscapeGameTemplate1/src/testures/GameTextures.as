package testures
{
	import com.in4ray.gaming.consts.TextureConsts;
	import com.in4ray.gaming.texturers.TextureBundle;

	public class GameTextures extends TextureBundle
	{
		public function GameTextures()
		{
			super();
			
			composerWidth = TextureConsts.MAX_WIDTH;
			composerHeight = TextureConsts.MAX_HEIGHT;
		}
		
	/*	override protected function registerTextures():void
		{
			registerTexture(Texture);
		}
		
		public function get texture():Texture
		{
			return getTexture(Texture);
		}*/
	}
}
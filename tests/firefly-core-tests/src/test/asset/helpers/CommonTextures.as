package test.asset.helpers
{
	import com.firefly.core.assets.TextureBundle;
	
	import starling.textures.Texture;
	
	import textures.CompanyLogo;
	
	public class CommonTextures extends TextureBundle
	{
		public function CommonTextures()
		{
			super();
		}
		
		override protected function regTextures():void
		{
			regFXGTexture(CompanyLogo);
		}
		
		public function get logo():Texture { return getTexture(CompanyLogo) };
	}
}
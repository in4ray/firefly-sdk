package test.textures.helpers
{
	import com.firefly.core.textures.DynamicTextureBundle;
	
	import starling.textures.Texture;
	
	import textures.CompanyLogo;
	import textures.GameName;
	import textures.MenuBackground;
	
	public class DynamicGameTextureBundle extends DynamicTextureBundle
	{
		override protected function regTextures():void
		{
			regBitmapTexture("bitmap_texture_scale", "../textures/bitmap_texture.png");
			regFXGTexture(CompanyLogo);
			regFXGTexture(MenuBackground);
			regFXGTexture(GameName);
		}
		
		public function get bitmapTexture():Texture { return getTexture("bitmap_texture_scale") };
		
		public function get companyLogo():Texture { return getTexture(CompanyLogo) };
		public function get menuBackground():Texture { return getTexture(MenuBackground) };
		public function get gameName():Texture { return getTexture(GameName) };
	}
}
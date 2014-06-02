package test.bundles.helpers
{
	import com.firefly.core.assets.TextureBundle;
	
	import starling.textures.TextureAtlas;
	
	import textures.TestFXG;
	
	public class TextureAtlasesBundle extends TextureBundle
	{
		public function TextureAtlasesBundle(generateMipMaps:Boolean=false)
		{
			super(generateMipMaps);
		}
		
		override protected function regTextures():void
		{
			regBitmapTextureAtlas("bitmap_texture_atlas", "../textures/game_sprites.png", "../textures/game_sprites.xml");
			regATFTextureAtlas("atf_texture_atlas", "../textures/game_sprites.atf", "../textures/game_sprites.xml");
			regFXGTextureAtlas("Test", [TestFXG], "/textures/TestFXG.xml");
		}
		
		public function get bitmapTextureAtlas():TextureAtlas { return getTextureAtlas("bitmap_texture_atlas") };
		public function get atfTextureAtlas():TextureAtlas { return getTextureAtlas("atf_texture_atlas") };
		public function get fxgTextureAtlas():TextureAtlas { return getTextureAtlas("Test") };
	}
}
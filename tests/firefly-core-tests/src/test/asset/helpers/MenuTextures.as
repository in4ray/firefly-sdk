package test.asset.helpers
{
	import com.firefly.core.assets.TextureBundle;
	import com.firefly.core.assets.loaders.textures.helpers.DragonBonesFactory;
	
	import starling.textures.Texture;
	
	import textures.MenuBackground;
	
	public class MenuTextures extends TextureBundle
	{
		public function MenuTextures()
		{
			super();
		}
		
		override protected function regTextures():void
		{
			regFXGTexture(MenuBackground);
			regBitmapTexture("bitmap_texture", "../textures/bitmap_texture.png");
			regATFTexture("atf_texture", "../textures/atf_texture.atf");
			regSWFTexture("swf_texture", "../textures/TestSWF.swf");
			regDragonBonesFactory("db_textures", "../textures/DragonBonesSWF.swf");
		}
		
		public function get background():Texture { return getTexture(MenuBackground) };
		public function get bitmapTexture():Texture { return getTexture("bitmap_texture") };
		public function get atfTexture():Texture { return getTexture("atf_texture") };
		public function get swfTexture():Texture { return getTexture("swf_texture") };
		public function get dbFactory():DragonBonesFactory { return getDragonBonesFactory("db_textures") };
	}
}
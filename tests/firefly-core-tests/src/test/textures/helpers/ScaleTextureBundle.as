package test.textures.helpers
{
	import com.firefly.core.textures.TextureBundle;
	
	import starling.textures.Texture;
	
	public class ScaleTextureBundle extends TextureBundle
	{
		override protected function regTextures():void
		{
			regBitmapTexture("bitmap_texture_scale", "../textures/bitmap_texture.png");
		}
		
		public function get bitmapTexture():Texture { return getTexture("bitmap_texture_scale") };
	}
}
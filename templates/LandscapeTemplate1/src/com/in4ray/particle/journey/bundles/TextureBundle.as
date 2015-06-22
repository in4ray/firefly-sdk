package com.in4ray.particle.journey.bundles
{
	import com.firefly.core.assets.TextureBundle;
	
	import starling.textures.Texture;
	
	import textures.GameName;
	import textures.PlayButton;
	
	public class TextureBundle extends com.firefly.core.assets.TextureBundle
	{
		public function TextureBundle()
		{
			super();
		}
		
		override protected function regTextures():void
		{
			regFXGTexture(GameName);
			regFXGTexture(PlayButton);
		}
		
		public function get playBtn():Texture { return getTexture(PlayButton) };
	}
}
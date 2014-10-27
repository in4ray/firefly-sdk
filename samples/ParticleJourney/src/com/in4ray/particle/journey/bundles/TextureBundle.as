package com.in4ray.particle.journey.bundles
{
	import com.firefly.core.assets.TextureBundle;
	
	import textures.GameName;
	
	public class TextureBundle extends com.firefly.core.assets.TextureBundle
	{
		public function TextureBundle()
		{
			super();
		}
		
		override protected function regTextures():void
		{
			regFXGTexture(GameName);
		}
	}
}
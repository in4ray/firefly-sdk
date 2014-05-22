package com.in4ray.particle.journey.textures
{
	
	import com.firefly.core.assets.TextureBundle;
	
	import starling.textures.Texture;
	
	import textures.CompanyLogo;
	import textures.MenuBackground;
	
	public class MenuTextures extends TextureBundle
	{
		public function MenuTextures()
		{
			super();
		}
		
		override protected function regTextures():void
		{
			regBitmapTexture("tex1", "../textures/265489,1321228337,1.jpg", false, true);
			regFXGTexture(CompanyLogo, false);
			regFXGTexture(MenuBackground, true, true);
			regBitmapTexture("tex2", "../textures/canstock1673768.jpg", false)
			regBitmapTexture("tex3", "../textures/canstock4346578.jpg", false);
			regBitmapTexture("tex4", "../textures/canstock4346578.jpg", false);
			regBitmapTexture("tex5", "../textures/canstock4346578.jpg", false);
			regBitmapTexture("tex6", "../textures/canstock4346578.jpg", false);
			regBitmapTexture("tex7", "../textures/canstock4346578.jpg", false);
			regBitmapTexture("tex8", "../textures/canstock4346578.jpg", false);
			regBitmapTexture("tex9", "../textures/canstock4346578.jpg", false);
			regBitmapTexture("tex10", "../textures/canstock4346578.jpg", false);
			regBitmapTextureAtlas("texAtlas", "../textures/game_sprites.png", "../textures/game_sprites.xml", false);
			
			// !!!! IMPORTENT: atf tested on AIR 3.8 and compile param "-swf-version=21"
			regATFTexture("atfLeaf", "../textures/leaf.atf");
			regATFTextureAtlas("atfAtlas", "../textures/game_sprites.atf", "../textures/game_sprites.xml");
			
			regBitmapTexture("myFont", "../fonts/Mauryssel.png");
			
			//regFXGTextureAtlas(TestFXG);
		}
		
		public function get menu():Texture { return getTexture(MenuBackground) };
		public function get tex1():Texture { return getTexture("tex1") };
		public function get tex2():Texture { return getTexture("tex2") };
		public function get tex3():Texture { return getTexture("tex3") };
		//public function get fxfAtlas():Texture { return getTextureAtlas(TestFXG).getTexture("element0") };
	}
}
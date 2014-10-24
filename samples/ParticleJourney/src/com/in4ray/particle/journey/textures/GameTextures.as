package com.in4ray.particle.journey.textures
{
	import com.firefly.core.assets.TextureBundle;
	import com.firefly.core.assets.loaders.textures.helpers.DragonBonesFactory;
	
	import starling.textures.Texture;
	
	import textures.CompanyLogo;
	import textures.MenuBackground;
	import textures.MenuBackground1;
	import textures.MenuBackground2;
	import textures.MenuBackground2013City1;
	import textures.MenuBackground2013City2;
	import textures.MenuBackground2013City3;
	import textures.MenuBackground2013City4;
	import textures.TestFXG;
	
	public class GameTextures extends TextureBundle
	{
		public function GameTextures()
		{
			super();
		}
		
		override protected function regTextures():void
		{
			regFXGTexture(MenuBackground, true, true);
			regFXGTexture(MenuBackground1, true, true);
			regFXGTexture(MenuBackground2, true, true);
			regFXGTexture(CompanyLogo, true);
			regFXGTexture(TestFXG, true);
			regFXGTexture(MenuBackground2013City1);
			regFXGTexture(MenuBackground2013City2);
			regFXGTexture(MenuBackground2013City3);
			regFXGTexture(MenuBackground2013City4);
			
			regDragonBonesFactory("bones1", "../textures/DragonBonesSWF.swf", true);
		}
		
		public function get bones1():DragonBonesFactory { return getDragonBonesFactory("bones1") }
		
		public function get companyLogo():Texture { return getTexture(CompanyLogo) }
		public function get city1():Texture { return getTexture(MenuBackground2013City1) }
		public function get city2():Texture { return getTexture(MenuBackground2013City2) }
		public function get city3():Texture { return getTexture(MenuBackground2013City3) }
		public function get city4():Texture { return getTexture(MenuBackground2013City4) }
	}
}
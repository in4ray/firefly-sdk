package com.in4ray.particle.journey.textures
{
	import com.firefly.core.textures.DynamicTextureBundle;
	import com.firefly.core.textures.helpers.DragonBonesFactory;
	
	import starling.textures.Texture;
	
	import textures.CompanyLogo;
	import textures.MenuBackground;
	import textures.MenuBackground1;
	import textures.MenuBackground2;
	import textures.TestFXG;
	
	public class GameTextures extends DynamicTextureBundle
	{
		public function GameTextures()
		{
			super();
			
			atlasSize = 1024;
		}
		
		override protected function regTextures():void
		{
			regFXGTexture(MenuBackground, true, true);
			regFXGTexture(MenuBackground1, true, true);
			regFXGTexture(MenuBackground2, true, true);
			regFXGTexture(CompanyLogo, true);
			regFXGTexture(TestFXG, true);
			
			regDragonBonesFactory("bones1", "../textures/DragonBonesSWF.swf", true);
		}
		
		public function get bones1():DragonBonesFactory { return getDragonBonesFactory("bones1") }
		
		public function get companyLogo():Texture { return getTexture(CompanyLogo) }
	}
}
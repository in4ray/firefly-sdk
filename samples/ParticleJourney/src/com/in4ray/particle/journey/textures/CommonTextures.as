package com.in4ray.particle.journey.textures
{
	import com.firefly.core.assets.TextureBundle;
	
	import particles.ParticleStar;
	
	import starling.textures.Texture;
	
	import textures.TestFXG;
	
	public class CommonTextures extends TextureBundle
	{
		public function CommonTextures()
		{
			super();
			
		}
		
		override protected function regTextures():void
		{
			regBitmapTexture("human", "../textures/human.png", false);
			regSWFTexture("swftest", "../textures/TestSWF.swf", false);
			regSWFTexture("dbswf", "../textures/DragonBonesSWF.swf", true);
			regFXGTexture(TestFXG);
			/*regFXGTexture(ParticleStar);
			regParticlePexXml("particleCloudXml", "../particles/particle.pex");
			regParticlePexXml("particleLvlUpXml", "../particles/particleLevelUp.pex");*/
		}
		
		public function get human():Texture { return getTexture("human"); }
		public function get swftest():Vector.<Texture> { return getTextureList("dbswf"); }
		
		public function get particleStar():Texture { return getTexture(ParticleStar); }
		public function get particleCloudXml():XML { return getParticleXML("particleCloudXml"); }
		public function get particleLvlUpXml():XML { return getParticleXML("particleLvlUpXml"); }
	}
}
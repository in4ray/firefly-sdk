package com.in4ray.particle.journey.fonts
{
	import com.firefly.core.assets.ParticleBundle;
	
	public class GameParticleBundle extends ParticleBundle
	{
		public function GameParticleBundle()
		{
			super();
		}
		
		override protected function regParticles():void
		{
			regParticleXML("myParticle1", "../particles/particle.pex");
			regParticleXML("myParticle2", "../particles/particleLevelUp.pex");
			regParticleXML("myParticle3", "../particles/particle3.pex");
			regParticleXML("myParticle4", "../particles/particle4.pex");
		}
	}
}
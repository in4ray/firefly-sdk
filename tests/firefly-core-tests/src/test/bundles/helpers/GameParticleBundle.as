package test.bundles.helpers
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
			regParticleXML("particle", "../particles/particle.pex");
		}
	}
}
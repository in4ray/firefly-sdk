package com.in4ray.particle.journey.globals
{
	import com.firefly.core.utils.SingletonLocator;
	import com.in4ray.particle.journey.bundles.ParticleBundle;
	
	
	public function get $prt():ParticleBundle
	{
		return SingletonLocator.getInstance(ParticleBundle);
	}
}
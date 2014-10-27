package com.in4ray.particle.journey.globals
{
	import com.firefly.core.utils.SingletonLocator;
	import com.in4ray.particle.journey.bundles.AudioBundle;
	
	
	public function get $audio():AudioBundle
	{
		return SingletonLocator.getInstance(AudioBundle);
	}
}
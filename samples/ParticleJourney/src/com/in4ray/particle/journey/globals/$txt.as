package com.in4ray.particle.journey.globals
{
	import com.firefly.core.utils.SingletonLocator;
	import com.in4ray.particle.journey.bundles.TextureBundle;
	
	
	public function get $txt():TextureBundle
	{
		return SingletonLocator.getInstance(TextureBundle);
	}
}
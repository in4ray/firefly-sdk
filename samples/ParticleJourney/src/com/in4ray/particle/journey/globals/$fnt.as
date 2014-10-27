package com.in4ray.particle.journey.globals
{
	import com.firefly.core.utils.SingletonLocator;
	import com.in4ray.particle.journey.bundles.FontBundle;
	
	
	public function get $fnt():FontBundle
	{
		return SingletonLocator.getInstance(FontBundle);
	}
}
package com.in4ray.particle.journey.globals
{
	import com.firefly.core.components.helpers.LocalizationField;
	import com.firefly.core.utils.SingletonLocator;
	import com.in4ray.particle.journey.bundles.LocalizationBundle;
	
	
	public function $loc(key:String):LocalizationField
	{
		return SingletonLocator.getInstance(LocalizationBundle).getLocaleField(key);
	}
}
package com.in4ray.particle.journey.components
{
	import com.firefly.core.components.Splash;
	import com.firefly.core.layouts.constraints.$hCenter;
	import com.firefly.core.layouts.constraints.$height;
	import com.firefly.core.layouts.constraints.$vCenter;
	import com.firefly.core.layouts.constraints.$width;

	import textures.FireflyLogo;

	public class FireflySplash extends Splash
	{
		public function FireflySplash()
		{
			super();
			
			layout.addElement(new FireflyLogo(), $width(50, true).pct, $height(50, true).pct, $vCenter(0), $hCenter(0));
		}
	}
}
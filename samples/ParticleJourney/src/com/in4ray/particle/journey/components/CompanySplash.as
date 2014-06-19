package com.in4ray.particle.journey.components
{
	import com.firefly.core.components.Splash;
	import com.firefly.core.layouts.constraints.$hCenter;
	import com.firefly.core.layouts.constraints.$vCenter;
	import com.firefly.core.layouts.constraints.$width;

	import textures.CompanyLogo;
	
	public class CompanySplash extends Splash
	{
		public function CompanySplash()
		{
			super();
            var s:CompanyLogo;
			layout.addElement(new CompanyLogo(), $width(50, true).pct, $vCenter(0), $hCenter(0));
		}
	}
}
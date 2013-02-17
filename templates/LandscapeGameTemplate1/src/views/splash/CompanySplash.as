package views.splash
{
	import com.in4ray.gaming.components.flash.Splash;
	import com.in4ray.gaming.layouts.$hCenter;
	import com.in4ray.gaming.layouts.$vCenter;
	import com.in4ray.gaming.layouts.$vRatio;
	
	import textures.CompanyLogo;

	public class CompanySplash extends Splash
	{
		public function CompanySplash()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			// Add Company logo
			addElement(new CompanyLogo(), $hCenter(0), $vCenter(0), $vRatio(50).pct);
		}
	}
}
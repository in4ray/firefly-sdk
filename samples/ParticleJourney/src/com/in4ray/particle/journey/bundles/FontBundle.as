package com.in4ray.particle.journey.bundles
{
	import com.firefly.core.assets.FontBundle;
	
	public class FontBundle extends com.firefly.core.assets.FontBundle
	{
		public function FontBundle()
		{
			super();
		}
		
		override protected function regFonts():void
		{
			regFontXML("myFont", "../fonts/Mauryssel.fnt");
		}
	}
}
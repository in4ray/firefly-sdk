package com.in4ray.particle.journey.fonts
{
	import com.firefly.core.assets.FontBundle;
	
	public class GameFontBundle extends FontBundle
	{
		public function GameFontBundle()
		{
			super();
		}
		
		override protected function regFonts():void
		{
			regFontXML("myFont", "../fonts/Mauryssel.fnt");
		}
	}
}
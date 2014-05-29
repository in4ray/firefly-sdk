package com.in4ray.particle.journey.locale
{
	import com.firefly.core.assets.LocalizationBundle;

	public class GameLocalizationBundle extends LocalizationBundle
	{
		public function GameLocalizationBundle()
		{
			super();
		}
		
		override protected function regLocales():void
		{
			regLocaleXML("en", "../locale/en.xml");
			regLocaleXML("ru", "../locale/ru.xml");
			regLocaleXML("ua", "../locale/ua.xml");
		}
	}
}
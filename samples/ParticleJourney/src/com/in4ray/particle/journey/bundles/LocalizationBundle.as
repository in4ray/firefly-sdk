package com.in4ray.particle.journey.bundles
{
	import com.firefly.core.assets.LocalizationBundle;

	public class LocalizationBundle extends com.firefly.core.assets.LocalizationBundle
	{
		public function LocalizationBundle()
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
package test.bundles.helpers
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
			regLocaleXML("ua", "../locale/ua.xml");
			regLocaleXML("en", "../locale/en.xml");
			regLocaleXML("ru", "../locale/ru.xml");
		}
	}
}
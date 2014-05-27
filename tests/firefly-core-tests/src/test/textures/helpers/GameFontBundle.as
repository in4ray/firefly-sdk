package test.textures.helpers
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
			regFontXML("font", "../fonts/Mauryssel.fnt");
		}
	}
}
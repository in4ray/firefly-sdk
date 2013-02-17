package sounds
{
	import com.in4ray.gaming.consts.SystemType;
	import com.in4ray.gaming.core.GameGlobals;
	
	import flash.utils.ByteArray;

	public class SoundBundle
	{
		[Embed(source="/sounds/click.mp3", mimeType="application/octet-stream")]
		private static var ClickClass:Class;
		
		[Embed(source="/sounds/MenuMusic.ogg", mimeType="application/octet-stream")]
		private static var MenuMusicClass:Class;
		
		public static function get click():ByteArray
		{
			return new ClickClass(); 
		}
		
		public static function get menuMusic():*
		{
			if(GameGlobals.systemType == SystemType.ANDROID)
				return new MenuMusicClass();
			else
				return new MenuMusicSwcClass(); 
		}
	}
}
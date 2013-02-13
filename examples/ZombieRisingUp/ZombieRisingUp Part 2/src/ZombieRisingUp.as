// =================================================================================================
//
//	Zombie: Rising Up
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================
package
{
	import com.in4ray.games.zombie.risingup.views.MainView;
	import com.in4ray.games.zombie.risingup.views.splash.CompanySplash;
	import com.in4ray.games.zombie.risingup.views.splash.GameSplash;
	import com.in4ray.gaming.components.flash.GameApplication;
	import com.in4ray.gaming.events.StarlingEvent;
	
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;

	[SWF (frameRate="30"]
	/**
	 * Game application. 
	 */	
	public class ZombieRisingUp extends GameApplication
	{
		[Embed(source="/fonts/Chango.fnt", mimeType="application/octet-stream")]
		private static const ChangoFontXml:Class;
		[Embed(source = "/fonts/Chango_0.png")]
		private static const ChangoFontTexture:Class;
		
		/**
		 * Constructor. 
		 */		
		public function ZombieRisingUp()
		{
			super();
			
			// Set textures size. For this particular game it will be:
			// Landscape: 1024 x 768 and 240 dpi
			setDesignSize(1024, 768);
			setDesignDPI(240);
			
			// Initialize company and game splash screens. 
			addSplash(new CompanySplash(), 2000);
			addSplash(new GameSplash(), 1000);
			
			addEventListener(StarlingEvent.STARLING_INITIALIZED, starlingInitializedHandler);
		}
		
		/**
		 * Starling initialized event handler.
		 * Place for textures and model registration, fonts loading.
		 */		
		protected function starlingInitializedHandler(event:StarlingEvent):void
		{
			registerFonts();
			setMainView(new MainView());
		}
			
		private function registerFonts():void
		{
			// Register bitmap fonts
			var ChangoTexture:Texture = Texture.fromBitmap(new ChangoFontTexture());
			var ChangoXml:XML = XML(new ChangoFontXml());
			TextField.registerBitmapFont(new BitmapFont(ChangoTexture, ChangoXml));
		}
	}
}
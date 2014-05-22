package com.in4ray.particle.journey.screens
{
	import com.firefly.core.assets.AssetState;
	import com.firefly.core.assets.FontBundle;
	import com.firefly.core.components.ScreenNavigator;
	import com.firefly.core.consts.GameState;
	import com.firefly.core.events.NavigationEvent;
	import com.firefly.core.transitions.BasicTransition;
	import com.in4ray.particle.journey.audio.GameAudioBundle;
	import com.in4ray.particle.journey.components.GameSplash;
	import com.in4ray.particle.journey.fonts.GameFontBundle;
	import com.in4ray.particle.journey.textures.CommonTextures;
	import com.in4ray.particle.journey.textures.GameTextures;
	import com.in4ray.particle.journey.textures.MenuTextures;
	
	public class MainScreen extends ScreenNavigator
	{
		public function MainScreen()
		{
			super();
			
			var splashTransition:BasicTransition = new BasicTransition(new GameSplash()); 
			var loadingTransition:BasicTransition = new BasicTransition(new LoadingScreen()); 
			
			assetManager.addState(new AssetState(GameState.MENU, new MenuTextures(), new CommonTextures(), new GameAudioBundle(), new GameFontBundle())); 
			assetManager.addState(new AssetState(GameState.GAME, new CommonTextures(), new GameTextures(), new GameAudioBundle()));
			
			controller.regScreen(GameState.MENU, MenuScreen, GameState.MENU);
			controller.regScreen(GameState.GAME, GameScreen, GameState.GAME);
			controller.regDialog(GameState.EXIT, ExitDialog);
			
			controller.regNavigation(NavigationEvent.TO_GAME, GameState.MENU, GameState.GAME ,splashTransition);
			controller.regNavigation(NavigationEvent.TO_MENU, GameState.GAME, GameState.MENU, splashTransition);
			controller.regNavigation(NavigationEvent.BACK, GameState.GAME, GameState.MENU, splashTransition);
			controller.regNavigation(NavigationEvent.INITIALIZE, "*", GameState.MENU, splashTransition);
			controller.regNavigation(NavigationEvent.BACK, GameState.MENU, GameState.EXIT);
		}
	}
}
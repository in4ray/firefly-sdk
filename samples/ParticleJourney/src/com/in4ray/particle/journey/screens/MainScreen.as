package com.in4ray.particle.journey.screens
{
	import com.firefly.core.assets.AssetState;
	import com.firefly.core.components.ScreenNavigator;
	import com.firefly.core.consts.GameState;
	import com.firefly.core.events.NavigationEvent;
	import com.in4ray.particle.journey.audio.GameAudioBundle;
	import com.in4ray.particle.journey.textures.CommonTextures;
	import com.in4ray.particle.journey.textures.GameTextures;
	import com.in4ray.particle.journey.textures.MenuTextures;
	
	public class MainScreen extends ScreenNavigator
	{
		public function MainScreen()
		{
			super();
			
			assetManager.addState(new AssetState(GameState.MENU, new MenuTextures(), new CommonTextures(), new GameAudioBundle())); 
			assetManager.addState(new AssetState(GameState.GAME, new CommonTextures(), new GameTextures(), new GameAudioBundle())); 
			
			controller.regScreen(GameState.MENU, MenuScreen, GameState.MENU);
			controller.regScreen(GameState.GAME, GameScreen, GameState.GAME);
			
			controller.regNavigation(NavigationEvent.TO_GAME, GameState.MENU, GameState.GAME);
			controller.regNavigation(NavigationEvent.TO_MENU, GameState.GAME, GameState.MENU);
			controller.regNavigation(NavigationEvent.BACK, GameState.GAME, GameState.MENU);
		}
	}
}
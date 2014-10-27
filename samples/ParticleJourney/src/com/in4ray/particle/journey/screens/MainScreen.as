package com.in4ray.particle.journey.screens
{
	import com.firefly.core.assets.AssetState;
	import com.firefly.core.components.ScreenNavigator;
	import com.firefly.core.consts.GameState;
	import com.firefly.core.events.NavigationEvent;
	import com.firefly.core.transitions.BasicTransition;
	import com.in4ray.particle.journey.bundles.LocalizationBundle;
	import com.in4ray.particle.journey.dialogs.ExitDialog;
	import com.in4ray.particle.journey.globals.$audio;
	import com.in4ray.particle.journey.globals.$fnt;
	import com.in4ray.particle.journey.globals.$prt;
	import com.in4ray.particle.journey.globals.$txt;
	import com.in4ray.particle.journey.splash.GameSplash;
	
	
	public class MainScreen extends ScreenNavigator
	{
		public function MainScreen()
		{
			super();
			
			var splashTransition:BasicTransition = new BasicTransition(new GameSplash()); 
			var loadingTransition:BasicTransition = new BasicTransition(new LoadingScreen()); 
			
			assetManager.addState(new AssetState(GameState.COMMON, $txt, $audio, $fnt, $prt, new LocalizationBundle())); 
			
			new LocalizationBundle().locale = "en";
			
			controller.regScreen(GameState.MENU, MenuScreen, GameState.COMMON);
			controller.regScreen(GameState.GAME, GameScreen, GameState.COMMON);
			controller.regDialog(GameState.EXIT, ExitDialog);
			
			controller.regNavigation(NavigationEvent.INITIALIZE, "*", GameState.MENU, splashTransition);
			controller.regNavigation(NavigationEvent.TO_GAME, GameState.MENU, GameState.GAME ,loadingTransition);
			controller.regNavigation(NavigationEvent.TO_MENU, GameState.GAME, GameState.MENU, loadingTransition);
			controller.regNavigation(NavigationEvent.BACK, GameState.GAME, GameState.MENU, loadingTransition);
			controller.regNavigation(NavigationEvent.BACK, GameState.MENU, GameState.EXIT);
		}
	}
}
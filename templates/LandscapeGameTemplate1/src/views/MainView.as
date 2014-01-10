package views
{
	import com.firefly.core.assets.AssetState;
	import com.firefly.core.audio.IAudio;
	import com.in4ray.gaming.components.Sprite;
	import com.in4ray.gaming.core.GameGlobals;
	import com.in4ray.gaming.events.SystemEvent;
	import com.in4ray.gaming.events.ViewStateEvent;
	import com.in4ray.gaming.navigation.ViewNavigator;
	import com.in4ray.gaming.navigation.ViewState;
	import com.in4ray.gaming.transitions.BasicTransition;
	import com.in4ray.gaming.transitions.LoadingTransition;
	import com.in4ray.gaming.transitions.PopUpTransition;
	
	import consts.ViewStates;
	
	import sounds.SoundBundle;
	
	import starling.events.Event;
	
	import textures.CommonTextures;
	import textures.MenuTextures;
	
	/**
	 * Game main view.
	 * Container for view navigator, game music, activate/deactivate event handlers.
	 * Menu view loaded by default within view navigator.   
	 */	
	public class MainView extends Sprite
	{
		private var audioEffect:IAudio;
		
		/**
		 * Constructor. 
		 */		
		public function MainView()
		{
			super();
			
			// Initialize game view navigator
			navigator = new ViewNavigator(this);
			
			// Get reference on game music
			audioEffect = new SoundBundle().menuMusic;
			
			// Create instance of texture state
			var menuTextureState:AssetState = new AssetState(ViewStates.MENU, new MenuTextures(), new CommonTextures(), new SoundBundle());
			var gameTextureState:AssetState = new AssetState(ViewStates.GAME, new CommonTextures(), new SoundBundle());
			
			// Add views and pop-ups within game view navigator 
			navigator.addView(MenuView, ViewStates.MENU, menuTextureState);
			navigator.addView(CreditsView, ViewStates.CREDITS, menuTextureState);
			navigator.addView(GameView, ViewStates.GAME, gameTextureState);
			navigator.addView(ScoreView, ViewStates.SCORE, menuTextureState);
			
			navigator.addPopUpView(PausePopUpView, ViewStates.PAUSE, menuTextureState);
			navigator.addPopUpView(ExitPopUpView, ViewStates.EXIT, menuTextureState);
			
			// Initialize additional game states
			var blackState:ViewState = new ViewState(BlackView);
			navigator.hibernateView = new LoadingView();
			navigator.lostContextView = new LostContextView();
			
			// Menu transitions
			navigator.addTransition(new BasicTransition(ViewStateEvent.SWITCH_TO_STATE, ViewStates.MENU, ViewStates.CREDITS));
			navigator.addTransition(new LoadingTransition(ViewStateEvent.SWITCH_TO_STATE, ViewStates.MENU, ViewStates.GAME, blackState));
			
			// Credits transitions
			navigator.addTransition(new BasicTransition(ViewStateEvent.SWITCH_TO_STATE, ViewStates.CREDITS, ViewStates.MENU));
			
			// Game transitions
			navigator.addTransition(new LoadingTransition(ViewStateEvent.SWITCH_TO_STATE, ViewStates.GAME, ViewStates.MENU, blackState));
			navigator.addTransition(new LoadingTransition(ViewStateEvent.SWITCH_TO_STATE, ViewStates.GAME, ViewStates.SCORE, blackState));
			navigator.addTransition(new LoadingTransition(ViewStateEvent.SWITCH_TO_STATE, ViewStates.GAME, ViewStates.GAME, blackState));
			
			// Score transitions
			navigator.addTransition(new LoadingTransition(ViewStateEvent.SWITCH_TO_STATE, ViewStates.SCORE, ViewStates.GAME, blackState));
			navigator.addTransition(new BasicTransition(ViewStateEvent.SWITCH_TO_STATE, ViewStates.SCORE, ViewStates.MENU));
			
			// Back device button (Android only), open popup, deactivate transitions
			navigator.addTransition(new BasicTransition(ViewStateEvent.BACK, ViewStates.CREDITS, ViewStates.MENU));
			navigator.addTransition(new BasicTransition(ViewStateEvent.BACK, ViewStates.SCORE, ViewStates.MENU));
			
			navigator.addTransition(new PopUpTransition(ViewStateEvent.OPEN_POPUP, ViewStates.MENU, ViewStates.EXIT));
			navigator.addTransition(new PopUpTransition(ViewStateEvent.BACK, ViewStates.MENU, ViewStates.EXIT));
			
			navigator.addTransition(new BasicTransition(ViewStateEvent.DEACTIVATE, ViewStates.GAME, ViewStates.PAUSE));
			navigator.addTransition(new BasicTransition(ViewStateEvent.BACK, ViewStates.GAME, ViewStates.PAUSE));
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
			GameGlobals.systemManager.addEventListener(SystemEvent.DEACTIVATE, deactivateHandler);
			GameGlobals.systemManager.addEventListener(SystemEvent.ACTIVATE, activateHandler);
		}
		
		private function addedToStageHandler():void
		{
			audioEffect.play(int.MAX_VALUE);
			dispatchEvent(new ViewStateEvent(ViewStateEvent.SWITCH_TO_STATE, ViewStates.MENU));
		}
		
		private function activateHandler():void
		{
			audioEffect.play(int.MAX_VALUE);
		}
		
		private function deactivateHandler():void
		{
			audioEffect.stop();
		}
	}
}
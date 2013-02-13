// =================================================================================================
//
//	Zombie: Rising Up
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================
package com.in4ray.games.zombie.risingup.views
{
	import com.in4ray.games.zombie.risingup.consts.ViewStates;
	import com.in4ray.gaming.async.callNextFrame;
	import com.in4ray.gaming.components.Sprite;
	import com.in4ray.gaming.components.TextField;
	import com.in4ray.gaming.events.ViewStateEvent;
	import com.in4ray.gaming.layouts.$height;
	import com.in4ray.gaming.layouts.$width;
	import com.in4ray.gaming.navigation.ViewNavigator;
	import com.in4ray.gaming.transitions.BasicTransition;
	import com.in4ray.gaming.transitions.PopUpTransition;
	
	import starling.events.Event;
	
	/**
	 * Game main view.
	 * Container for view navigator, game music, activate/deactivate event handlers.
	 * Menu view loaded by default within view navigator.   
	 */	
	public class MainView extends Sprite
	{
		/**
		 * Constructor. 
		 */		
		public function MainView()
		{
			super();
			
			// Initialize game view navigator
			navigator = new ViewNavigator(this);
			
			// Add views and pop-ups within game view navigator 
			navigator.addView(MenuView, ViewStates.MENU);
			navigator.addView(CreditsView, ViewStates.CREDITS);
			navigator.addView(GameView, ViewStates.GAME);
			navigator.addView(ScoreView, ViewStates.SCORE);
			
			navigator.addPopUpView(PausePopUpView, ViewStates.PAUSE);
			navigator.addPopUpView(ExitPopUpView, ViewStates.EXIT);
			
			// Initialize additional game states
			navigator.hibernateView = new LoadingView();
			navigator.lostContextView = new LostContextView();
			
			// Menu transitions
			navigator.addTransition(new BasicTransition(ViewStateEvent.SWITCH_TO_STATE, ViewStates.MENU, ViewStates.CREDITS));
			navigator.addTransition(new BasicTransition(ViewStateEvent.SWITCH_TO_STATE, ViewStates.MENU, ViewStates.GAME));
			
			// Credits transitions
			navigator.addTransition(new BasicTransition(ViewStateEvent.SWITCH_TO_STATE, ViewStates.CREDITS, ViewStates.MENU));
			
			// Game transitions
			navigator.addTransition(new BasicTransition(ViewStateEvent.SWITCH_TO_STATE, ViewStates.GAME, ViewStates.MENU));
			navigator.addTransition(new BasicTransition(ViewStateEvent.SWITCH_TO_STATE, ViewStates.GAME, ViewStates.SCORE));
			navigator.addTransition(new BasicTransition(ViewStateEvent.SWITCH_TO_STATE, ViewStates.GAME, ViewStates.GAME));
			
			// Score transitions
			navigator.addTransition(new BasicTransition(ViewStateEvent.SWITCH_TO_STATE, ViewStates.SCORE, ViewStates.GAME));
			navigator.addTransition(new BasicTransition(ViewStateEvent.SWITCH_TO_STATE, ViewStates.SCORE, ViewStates.MENU));
			
			// Back device button (Android only), open popup, deactivate transitions
			navigator.addTransition(new BasicTransition(ViewStateEvent.BACK, ViewStates.CREDITS, ViewStates.MENU));
			navigator.addTransition(new BasicTransition(ViewStateEvent.BACK, ViewStates.SCORE, ViewStates.MENU));
			
			navigator.addTransition(new PopUpTransition(ViewStateEvent.OPEN_POPUP, ViewStates.MENU, ViewStates.EXIT));
			navigator.addTransition(new PopUpTransition(ViewStateEvent.BACK, ViewStates.MENU, ViewStates.EXIT));
			
			navigator.addTransition(new BasicTransition(ViewStateEvent.DEACTIVATE, ViewStates.GAME, ViewStates.PAUSE));
			navigator.addTransition(new BasicTransition(ViewStateEvent.BACK, ViewStates.GAME, ViewStates.PAUSE));
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler():void
		{
			dispatchEvent(new ViewStateEvent(ViewStateEvent.SWITCH_TO_STATE, ViewStates.MENU));
		}
	}
}
// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.components
{
	import com.firefly.core.Firefly;
	import com.firefly.core.assets.AssetManager;
	import com.firefly.core.controllers.ScreenNavigatorCtrl;
	import com.firefly.core.display.IDialog;
	import com.firefly.core.display.IScreenNavigator;
	import com.firefly.core.display.IView;
	import com.firefly.core.events.ScreenNavigatorEvent;
	import com.firefly.core.layouts.Layout;
	import com.firefly.core.layouts.constraints.$height;
	import com.firefly.core.layouts.constraints.$pivotX;
	import com.firefly.core.layouts.constraints.$pivotY;
	import com.firefly.core.layouts.constraints.$width;
	import com.firefly.core.layouts.constraints.$x;
	import com.firefly.core.layouts.constraints.$y;
	
	import starling.display.DisplayObject;
	
	/** The ScreenNavigator is container which has possibility to add screens and dialog to it. 
	 *  This component automatically switches between different screens. All view states with 
	 *  appropriate screens should be registered using screen navigator controller. By default 
	 *  size of the screen is the same as Stage. 
	 *  
	 *  @see com.firefly.core.components.Dialog
	 *  @see com.firefly.core.components.Screen
	 *  @see com.firefly.core.controllers.ScreenNavigatorCtrl
	 *  @see com.firefly.core.assets.AssetManager 
	 * 
	 *  @example The following code shows how configure screen navigator, register screens and dialogs:
	 *  <listing version="3.0">
	 *************************************************************************************
public class MainScreen extends ScreenNavigator
{
	public function MainScreen()
	{
		super();
			
		var splashTransition:BasicTransition = new BasicTransition(new MyGameSplash()); 
		var loadingTransition:BasicTransition = new BasicTransition(new MyLoadingScreen()); 
			
		assetManager.addState(new AssetState(GameState.COMMON, new MyTextureBundle(), new MyAudioBundle(), 
							  new MyFontBundle(), new MyParticleBundle(), new MyLocalizationBundle()));
			
		new MyLocalizationBundle().locale = "en";
			
		controller.regScreen(GameState.MENU, MenuScreen, GameState.COMMON);
		controller.regScreen(GameState.GAME, GameScreen, GameState.COMMON);
		controller.regScreen(GameState.SCORE, ScoreScreen, GameState.COMMON);

		controller.regDialog(GameState.PAUSE, PauseDialog);
			
		controller.regNavigation(NavigationEvent.INITIALIZE, "*", GameState.MENU, splashTransition);
		controller.regNavigation(NavigationEvent.TO_MENU, GameState.GAME, GameState.MENU, loadingTransition);
		
		controller.regNavigation(NavigationEvent.TO_GAME, GameState.MENU, GameState.GAME, loadingTransition);
		controller.regNavigation(NavigationEvent.TO_GAME, GameState.SCORE, GameState.GAME, loadingTransition);
		controller.regNavigation(NavigationEvent.TO_GAME, GameState.PAUSE, GameState.GAME, loadingTransition);
		
		controller.regNavigation(NavigationEvent.TO_SCORE, GameState.GAME, GameState.SCORE, loadingTransition);
		controller.regNavigation(NavigationEvent.TO_PAUSE, GameState.GAME, GameState.PAUSE);
		controller.regNavigation(NavigationEvent.DEACTIVATE, GameState.GAME, GameState.PAUSE);
		
		controller.regNavigation(NavigationEvent.BACK, GameState.GAME, GameState.MENU, loadingTransition);
		controller.regNavigation(NavigationEvent.BACK, GameState.MISSIONS, GameState.MENU, loadingTransition);
		controller.regNavigation(NavigationEvent.BACK, GameState.SCORE, GameState.MENU);
	}
}
	 *************************************************************************************
	 *  </listing> */
	public class ScreenNavigator extends Component implements IScreenNavigator
	{
		/** @orivate */		
		private var _assetManager:AssetManager;
		/** @orivate */
		private var _controller:ScreenNavigatorCtrl;
		/** @orivate */
		private var _layout:Layout;
		
		/** Constructor. */		
		public function ScreenNavigator()
		{
			super();
			
			_layout = new Layout(this);
			_assetManager = new AssetManager();
			_controller = new ScreenNavigatorCtrl(this, _assetManager);
			_controller.addEventListener(ScreenNavigatorEvent.INITIALIZED, initialized);
			
			width = Firefly.current.stageWidth;
			height = Firefly.current.stageHeight;
		}
		
		/** Instance of asset manager. */		
		public function get assetManager():AssetManager { return _assetManager; }
		
		/** Instance of screen navigator controller. */
		public function get controller():ScreenNavigatorCtrl { return _controller; }
		
		/** This function adds the view component to the screen navigator.
		 *  @param view Instance of the view or screen component.
		 *  @param index Position of the view component in the screen navigator. */		
		public function addView(view:IView, index:int=-1):void 
		{
			if(index > -1)
				_layout.addElementAt(view, index, $width(100).pct, $height(100).pct);
			else
				_layout.addElement(view, $width(100).pct, $height(100).pct); 
		}
		
		/** This function removes view component from the screen navigator
		 *  @param view Instance of the view component. */		
		public function removeView(view:IView):void 
		{ 
			removeChild(view as DisplayObject);	
		}
		
		/** This function adds the dialog to the screen navigator.
		 *  @param dialog Instance of the dialog. */		
		public function addDialog(dialog:IDialog):void
		{
			_layout.addElement(dialog, $pivotX(50).pct, $pivotY(50).pct, $x(50).pct, $y(50).pct); 
		}
		
		/** First asset state is loaded and controller is initialized */
		protected function initialized():void
		{
		}
	}
}
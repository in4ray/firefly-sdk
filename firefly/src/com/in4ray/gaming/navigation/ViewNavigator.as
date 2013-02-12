// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.navigation
{
	import com.in4ray.gaming.components.Sprite;
	import com.in4ray.gaming.components.flash.Sprite;
	import com.in4ray.gaming.consts.CreationPolicy;
	import com.in4ray.gaming.events.ViewStateEvent;
	import com.in4ray.gaming.layouts.$height;
	import com.in4ray.gaming.layouts.$width;
	import com.in4ray.gaming.core.GameGlobals;
	import com.in4ray.gaming.texturers.TextureManager;
	import com.in4ray.gaming.texturers.TextureState;
	import com.in4ray.gaming.transitions.BasicTransition;
	import com.in4ray.gaming.transitions.ITransition;
	
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	
	import avmplus.getQualifiedClassName;
	
	import starling.core.Starling;
	import starling.events.Event;
	
	/**
	 * View navigation manager that manage view states: <br/>
	 * 1. Switching between views. <br/>
	 * 2. Adding popups.<br/>
	 * 3. Loading texture states.<br/>
	 * 4. Playing transition animations.<br/>
	 * 5. Supporting hibernate.<br/>
	 * 6. Handling device Back button (for Android platform).
	 * 
	 * @example The following example shows how to configure view navigator:
	 *
	 * <listing version="3.0">
import com.in4ray.games.core.components.Sprite;
import com.in4ray.games.core.events.ViewStateEvent;
import com.in4ray.games.core.navigation.ViewNavigator;
import com.in4ray.games.core.navigation.ViewState;
import com.in4ray.games.core.texturers.TextureManager;
import com.in4ray.games.core.texturers.TextureState;
import com.in4ray.games.core.transitions.BasicTransition;
import com.in4ray.games.core.transitions.LoadingTransition;
import com.in4ray.games.core.transitions.PopUpTransition;

public class MainView extends Sprite
{
	private var textureManager:TextureManager;
	
	public function MainView()
	{
		// Initialize game view navigator
		navigator = new ViewNavigator(this);
		
		// Create instance of texture state
		var menuState:TextureState = new TextureState(new MenuTextureBundle(), new CommonTextureBundle());
		var gameState:TextureState = new TextureState(new GameTextureBundle(), new CommonTextureBundle());
		
		// Add views and pop-ups within game view navigator 
		navigator.addView(MenuView, ViewStates.MENU, textureState);
		navigator.addView(CreditsView, ViewStates.CREDITS, textureState);
		navigator.addView(GameView, ViewStates.GAME, textureState);
		navigator.addView(ScoreView, ViewStates.SCORE, textureState);
		
		navigator.addPopUpView(PausePopUpView, ViewStates.PAUSE, textureState);
		navigator.addPopUpView(ExitPopUpView, ViewStates.EXIT, textureState);
		
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
		
		// Load textures and navigate to the Menu view
		textureState.loadAsync(dispatchEvent, new ViewStateEvent(ViewStateEvent.SWITCH_TO_STATE, ViewStates.MENU));
	}
}
	 * </listing>
	 */	
	public class ViewNavigator
	{
		/**
		 * Constructor. 
		 * 
		 * @param container View navigation container.
		 */		
		public function ViewNavigator(container:com.in4ray.gaming.components.Sprite)
		{
			this.container = container;
		}
		
		private var _container:com.in4ray.gaming.components.Sprite;
		
		/**
		 * View navigation container.
		 */		
		public function get container():com.in4ray.gaming.components.Sprite
		{
			return _container;
		}
		
		public function set container(value:com.in4ray.gaming.components.Sprite):void
		{
			removeTriggerListeners();
			
			_container = value;
			
			addTriggerListeners();
			
			if(_container.parent)
				addedToStageHandler();
		}
		
		/**
		 * Texture managerm that manages texture states. 
		 */		
		public var textureManager:TextureManager = new TextureManager();
		
		/**
		 * Add view state.
		 *  
		 * @param viewClass View class that will be instantiated automatically.
		 * @param name State name.
		 * @param textureState Texture state that will be loadedwhen manager switches to this state.
		 * @param creaionPolicy Createion policy for creating view class.
		 * 
		 * @see com.in4ray.games.core.consts.CreationPolicy
		 */		
		public function addView(viewClass:Class, name:String, textureState:TextureState = null, creaionPolicy:String = CreationPolicy.ONDEMAND):void
		{
			_viewStates[name] = new ViewState(viewClass, false, name, textureState, creaionPolicy);
			if(textureState)
				textureManager.addState(textureState);
		}
		
		/**
		 * Add popup view.
		 *  
		 * @param viewClass View class that will be instantiated automatically.
		 * @param name State name.
		 * @param textureState Texture state that will be loadedwhen manager switches to this state.
		 * @param creaionPolicy Createion policy for creating view class.
		 * 
		 * @see com.in4ray.games.core.consts.CreationPolicy
		 */		
		public function addPopUpView(viewClass:Class, name:String, textureState:TextureState = null, creaionPolicy:String = CreationPolicy.ONDEMAND):void
		{
			_viewStates[name] = new ViewState(viewClass, true, name, textureState, creaionPolicy);
			if(textureState)
				textureManager.addState(textureState);
		}
		
		private function addTriggerListeners():void
		{
			if(_container)
			{
				_container.addEventListener(starling.events.Event.ADDED_TO_STAGE, addedToStageHandler);
				_container.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			}
		}
		
		private function removeTriggerListeners():void
		{
			if(_container)
			{
				_container.removeEventListener(starling.events.Event.ADDED_TO_STAGE, addedToStageHandler);
				_container.removeEventListener(starling.events.Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			}
		}
		
		private function addedToStageHandler(event:starling.events.Event=null):void
		{
			_container.addEventListener(ViewStateEvent.ACTIVATE, startTransitionHandler);
			_container.addEventListener(ViewStateEvent.DEACTIVATE, startTransitionHandler);
			_container.addEventListener(ViewStateEvent.BACK, startTransitionHandler);
			_container.addEventListener(ViewStateEvent.CONTEXT_CREATE, startTransitionHandler);
			_container.addEventListener(ViewStateEvent.CONTEXT_LOST, startTransitionHandler);
			_container.addEventListener(ViewStateEvent.OPEN_POPUP, startTransitionHandler);
			_container.addEventListener(ViewStateEvent.SWITCH_TO_STATE, startTransitionHandler);
			_container.addEventListener(ViewStateEvent.CLOSE_POPUP, closePoPupHandler);
			NativeApplication.nativeApplication.addEventListener(flash.events.Event.ACTIVATE, activateHandler);	
			NativeApplication.nativeApplication.addEventListener(flash.events.Event.DEACTIVATE, deactivateHandler);
			Starling.current.stage3D.addEventListener(flash.events.Event.CONTEXT3D_CREATE, contextCreateHandler, false, 0, true);
			GameGlobals.gameApplication.stage.addEventListener(KeyboardEvent.KEY_DOWN, onBackKeyDown);
		}
		
		private function removedFromStageHandler(event:starling.events.Event):void
		{
			_container.removeEventListener(ViewStateEvent.ACTIVATE, startTransitionHandler);
			_container.removeEventListener(ViewStateEvent.DEACTIVATE, startTransitionHandler);
			_container.removeEventListener(ViewStateEvent.BACK, startTransitionHandler);
			_container.removeEventListener(ViewStateEvent.CONTEXT_CREATE, startTransitionHandler);
			_container.removeEventListener(ViewStateEvent.CONTEXT_LOST, startTransitionHandler);
			_container.removeEventListener(ViewStateEvent.OPEN_POPUP, startTransitionHandler);
			_container.removeEventListener(ViewStateEvent.SWITCH_TO_STATE, startTransitionHandler);
			_container.removeEventListener(ViewStateEvent.CLOSE_POPUP, closePoPupHandler);
			NativeApplication.nativeApplication.removeEventListener(flash.events.Event.ACTIVATE, activateHandler);	
			NativeApplication.nativeApplication.removeEventListener(flash.events.Event.DEACTIVATE, deactivateHandler);
			Starling.current.stage3D.removeEventListener(flash.events.Event.CONTEXT3D_CREATE, contextCreateHandler);
			GameGlobals.gameApplication.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onBackKeyDown);
		}
		
		/**
		 * Flash view (loading indicator) that will be shown while starling context restoring. 
		 */		
		public var lostContextView:com.in4ray.gaming.components.flash.Sprite;
		
		/**
		 * Starling view (loading indicator) that will be shown while restoring from hibernate.
		 */		
		public var hibernateView:com.in4ray.gaming.components.Sprite;
		
		/**
		 * @private 
		 */		
		protected function activateHandler(event:flash.events.Event):void
		{
			if(!Starling.current.context)
			{
				textureManager.active = false;
				textureManager.releaseCurrentState();
				_container.dispatchEvent(new ViewStateEvent(ViewStateEvent.CONTEXT_LOST));
			}
			else
			{
				_container.dispatchEvent(new ViewStateEvent(ViewStateEvent.ACTIVATE));
				textureManager.active = true;
				if(hibernateView)
				{
					_container.addElement(hibernateView, $width(100).pct, $height(100).pct);
					textureManager.loadCurrentStateAsync(_container.removeChild, hibernateView);
				}
				else
				{
					textureManager.loadCurrentState();
				}
			}
		}
		
		/**
		 * @private 
		 */
		protected function deactivateHandler(event:flash.events.Event):void
		{
			/*textureManager.active = false;
			textureManager.releaseCurrentState();*/
			_container.dispatchEvent(new ViewStateEvent(ViewStateEvent.DEACTIVATE));
		}
		
		/**
		 * @private 
		 */
		protected function contextCreateHandler(event:flash.events.Event):void
		{
			_container.dispatchEvent(new ViewStateEvent(ViewStateEvent.CONTEXT_CREATE));
			textureManager.active = true;
			if(lostContextView)
			{
				lostContextView.setActualSize( GameGlobals.stageSize.x, GameGlobals.stageSize.y);
				Starling.current.nativeOverlay.addChild(lostContextView);
				textureManager.loadCurrentStateAsync(Starling.current.nativeOverlay.removeChild, lostContextView);
			}
			else
			{
				textureManager.loadCurrentState();
			}
		}
		
		/**
		 * @private 
		 */
		protected function onBackKeyDown(event:KeyboardEvent):void
		{
			if(!event.isDefaultPrevented() && container && container.parent)
			{
				if(event.keyCode == Keyboard.BACK)
				{
					_container.dispatchEvent(new ViewStateEvent(ViewStateEvent.BACK));					
					event.preventDefault();
				}
			}
		}
		
		//************************ states *****************************/
		private var _viewStates:Dictionary = new Dictionary();
		
		/**
		 * Current view class. 
		 */		
		public var currentViewState:ViewState;
		
		/**
		 * @private 
		 */
		protected function startTransitionHandler(event:ViewStateEvent):void
		{
			if(event.type == ViewStateEvent.BACK && currentPopUpState)
			{
				closePoPupHandler(new ViewStateEvent(ViewStateEvent.BACK, currentPopUpState.name));
				return;
			}
			
			var toState:ViewState;
			if(event.state)
				toState = _viewStates[event.state];
			else if(currentViewState)
				toState = _viewStates[resolveToState(event.type, currentViewState.name)];
			
			if(toState)
			{
				var fromState:ViewState = currentViewState;
				
				CONFIG::debugging {trace("[in4ray] " + event.type + " [" + (fromState ? fromState.viewClass : null) + "] -> [" + (toState ? toState.viewClass : null) + "]")};
				
				if(!toState.popUp)
				{
					currentViewState = toState;
				}
				else
				{
					currentPopUpState = toState;
					showPoPupCover();
				}
				
				var transition:ITransition = getAppropriateTransition(event.type, fromState, toState);
				transition.play((toState.popUp ? null : fromState), toState);
			}
		}
		
		private var currentPopUpState:ViewState;
		
		/**
		 * Popup cover that will be shown under popup to emphasize it.  
		 */		
		public var poPupCover:PopUpCover = new PopUpCover();
		
		/**
		 * @private 
		 */
		protected function showPoPupCover():void
		{
			if(poPupCover && !_container.contains(poPupCover))
				_container.addElement(poPupCover, $width(100).pct, $height(100).pct);
		}
		
		/**
		 * @private 
		 */
		protected function hidePoPupCover():void
		{
			if(poPupCover)
				_container.removeChild(poPupCover);
		}
		
		/**
		 * @private 
		 */
		protected function closePoPupHandler(event:ViewStateEvent):void
		{
			var state:ViewState = _viewStates[event.state];
			if(state)
			{
				_container.removeChild(state.getView());
				currentPopUpState = null;
				hidePoPupCover();
			}
		}
		
		/**
		 * @private 
		 */		
		public function hideViewState(viewState:ViewState):void
		{
			if(viewState)
				_container.removeChild(viewState.getView());
		}
		
		/**
		 * @private 
		 */	
		public function showViewState(viewState:ViewState):void
		{
			if(viewState && !_container.contains(viewState.getView()))
				_container.addElement(viewState.getView());
		}
		
		//************************ transitions *****************************/
		private var transitions:Vector.<ITransition> = new Vector.<ITransition>();
		
		/**
		 * Add transition animation for switching between states.
		 * @param transition Transition instance.
		 */		
		public function addTransition(transition:ITransition):void
		{
			transitions.push(transition);
		}
		
		private var basicTransition:BasicTransition = new BasicTransition("default", "*", "*");
		
		private function resolveToState(trigger:String, fromState:String):String
		{
			var transition:ITransition = searchTransition(trigger, fromState);
			
			if(!transition)
				transition =  searchTransition(trigger, "*");
			
			if(transition)
				return transition.toState;
			
			return null;
		}	
		
		private function getAppropriateTransition(trigger:String, fromState:ViewState, toState:ViewState):ITransition
		{
			var transition:ITransition; 
			if(fromState)
				transition = searchTransition(trigger, fromState.name, toState.name);
			
			if(!transition)
				transition = searchTransition(trigger, "*", toState.name);
			
			if(!transition && fromState)
				transition = searchTransition(trigger, fromState.name, "*");
			
			if(!transition && fromState)
				transition = searchTransition(trigger, "*", "*");
			
			if(!transition)
				transition = basicTransition;
			
			transition.navigator = this;
			
			return transition;
		}
		
		private function searchTransition(trigger:String, fromState:String, toState:String=null):ITransition
		{
			for each (var transition:ITransition in transitions) 
			{
				if(transition.trigger == trigger && transition.fromState == fromState && (!toState || transition.toState == toState))
					return transition;
			}
			
			return null;
		}
	}
}
// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.controllers
{
	import com.firefly.core.Firefly;
	import com.firefly.core.assets.AssetManager;
	import com.firefly.core.controllers.helpers.DialogProxy;
	import com.firefly.core.controllers.helpers.Navigation;
	import com.firefly.core.controllers.helpers.ViewState;
	import com.firefly.core.display.IDialog;
	import com.firefly.core.display.IScreen;
	import com.firefly.core.display.IScreenNavigator;
	import com.firefly.core.display.IView;
	import com.firefly.core.events.NavigationEvent;
	import com.firefly.core.events.ScreenNavigatorEvent;
	import com.firefly.core.utils.ClassFactory;
	import com.firefly.core.utils.Log;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	[Event(name="stateChanged", type="com.firefly.core.events.ScreenNavigatorEvent")]
	[Event(name="initialized", type="com.firefly.core.events.ScreenNavigatorEvent")]
	
	/** The ScreenNavigatorCtrl is the controller which manages set of screens in screen navigator, 
	 *  switches between view states the view using navigation transitions. 
	 * 
	 *  @see com.firefly.core.components.ScreenNavigator */
	public class ScreenNavigatorCtrl extends NavigatorCtrl
	{
		/** @private */		
		private var _splashClass:ClassFactory;
		/** @private */
		private var _dialogStack:ViewStackCtrl;
		/** @private */
		private var _dialogProxy:DialogProxy;
		/** @private */
		private var _closeNavigationState:String;
		
		/** Constructor.
		 *  @param screenNavigator Screen navigator component which contains screens.
		 *  @param assetManager Instance of asset manager. */		
		public function ScreenNavigatorCtrl(screenNavigator:IScreenNavigator, assetManager:AssetManager)
		{
			super(screenNavigator, assetManager);
			
			_dialogProxy = new DialogProxy(screenNavigator);
			_dialogStack = new ViewStackCtrl(_dialogProxy, int.MAX_VALUE);
			
			screenNavigator.addEventListener(NavigationEvent.CLOSE_DIALOG, onCloseDialog);
			Firefly.current.main.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			Firefly.current.main.stage.addEventListener(flash.events.Event.ACTIVATE, onActivate);
			Firefly.current.main.stage.addEventListener(flash.events.Event.DEACTIVATE, onDeactivate);
		}
		
		/** @inheritDoc */		
		override public function navigate(trigger:String, data:Object=null):Boolean
		{
			var navigation:Navigation = getNavigation(trigger, currentStateName)
			if(navigation)
			{
				if(_dialogStack.getState(navigation.toState))
				{
					var state:ViewState = getState(navigation.fromState);
					openDialog(navigation.toState, data);
					return true;
				}
			}
			
			return super.navigate(trigger, data);
		}
		
		/** @inheritDoc */	
		override protected function assetStateSwitched(toState:String, data:Object):void
		{
			super.assetStateSwitched(toState, data);
			if(data == NavigationEvent.INITIALIZE)
				dispatchEvent(new ScreenNavigatorEvent(ScreenNavigatorEvent.INITIALIZED, toState));
			else
				dispatchEvent(new ScreenNavigatorEvent(ScreenNavigatorEvent.STATE_CHANGED, toState));
		}
		
		/** Register splash screen in the controller.
		 *  @param splashClass Splash screen class. Controller automatically will create the instance. */		
		public function regSplash(splashClass:Class):void
		{
			_splashClass = new ClassFactory(splashClass);
		}
		
		/** Register screen in the controller. Prepare view state.
		 *  @param state View state name.
		 *  @param screenClass Screen class. Controller automatically will create the instance.
		 *  @param assetState Asset state name.
		 *  @param cache Defines caching of view component instance. */		
		public function regScreen(state:String, screenClass:Class, assetState:String, cache:Boolean=true):void
		{
			regState(new ViewState(state, new ClassFactory(screenClass), assetState, cache));
		}
		
		/** Register dialog in the controller. Prepare view state.
		 *  @param state View state name.
		 *  @param dialogClass Dialog class. Controller automatically will create the instance.
		 *  @param cache Defines caching of view component instance. */		
		public function regDialog(state:String, dialogClass:Class, cache:Boolean=true):void
		{
			_dialogStack.regState(new ViewState(state, new ClassFactory(dialogClass), null));
		}
		
		/** Register close navigation. This navigation invokes when user clickes back button on registered state
		 *  and any other simple navigations aren't registered.
		 *  @param fromState From which state should be navigation. */		
		public function regCloseNavigation(fromState:String):void
		{
			_closeNavigationState = fromState;
		}
		
		/** Show dialog on the screen by name.
		 *  @param name Dialog name previously registered in the controller.
		 *  @param data Specific data which will be send to the opened dialog.
		 *  @return Showed dialog. */		
		public function openDialog(name:String, data:Object=null):IDialog
		{
			if (currentState.instance is IScreen)
				return _dialogStack.show(name, data, assignScreen) as IDialog;
			else
				return _dialogStack.show(name, data) as IDialog;
		}
		
		/** Close dialog by name.
		 *  @param name Dialog name. */		
		public function closeDialog(name:String):void
		{
			_dialogStack.hide(name);
			
			if (_dialogStack.numOpenedViews == 0 && currentState && currentState.instance is IScreen)
				(currentState.instance as IScreen).activate();
		}
		
		/** Start controller work. */		
		public function start():void
		{
			navigate(NavigationEvent.INITIALIZE, NavigationEvent.INITIALIZE);
		}
		
		/** Get top showed dialog.
		 *  @return Instance of the dialog. */		
		public function getTopDialog():IDialog
		{
			return _dialogStack.topState ? _dialogStack.topState.instance as IDialog : null;
		}
		
		/** @private */		
		private function assignScreen(view:IView):void
		{
			(currentState.instance as IScreen).deactivate();
			(view as IDialog).screen = currentState.instance as IScreen;
		}
		
		/** @private */
		private function onActivate(event:flash.events.Event):void
		{
			if(_assetManager.isDirty())
			{
				CONFIG::debug {
					Log.info("Restoring lost context.");
				};
				
				navigate(NavigationEvent.RESTORE_CONTEXT);
			}
			else
			{
				navigate(NavigationEvent.ACTIVATE);
			}
		}
		
		/** @private */
		private function onDeactivate(event:flash.events.Event):void
		{
			navigate(NavigationEvent.DEACTIVATE);
		}
		
		/** @private */
		private function onCloseDialog(e:NavigationEvent):void
		{
			if(e.data && e.data is String)
				_dialogStack.hide(e.data as String);
			else
				_dialogStack.hideTop();
			
			if (_dialogStack.numOpenedViews == 0 && currentState && currentState.instance is IScreen)
				(currentState.instance as IScreen).activate();
		}
		
		/** @private */
		private function onKeyDown(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.BACK)
			{	
				var navigated:Boolean;
				var dialog:IDialog = getTopDialog();
				if(dialog)
				{
					dialog.onBack();
					_dialogStack.hideTop();
					navigated = true;
				}
				else
				{
					navigated = navigate(NavigationEvent.BACK);
				}
				
				event.preventDefault();
				
				if (!navigated && _closeNavigationState == currentStateName)
					Firefly.current.exit();
			}
		}
	}
}
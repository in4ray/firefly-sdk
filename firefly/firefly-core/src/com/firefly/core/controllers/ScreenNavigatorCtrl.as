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
	
	public class ScreenNavigatorCtrl extends NavigatorCtrl
	{
		private var _splashClass:ClassFactory;
		private var _dialogStack:ViewStackCtrl;
		private var _dialogProxy:DialogProxy;
		private var _closeNavigationState:String;
		
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
		
		override protected function assetStateSwitched(toState:String, data:Object):void
		{
			super.assetStateSwitched(toState, data);
			if(data == NavigationEvent.INITIALIZE)
				dispatchEvent(new ScreenNavigatorEvent(ScreenNavigatorEvent.INITIALIZED, toState));
			else
				dispatchEvent(new ScreenNavigatorEvent(ScreenNavigatorEvent.STATE_CHANGED, toState));
		}
		
		public function regSplash(splashClass:Class):void
		{
			_splashClass = new ClassFactory(splashClass);
		}
		
		public function regScreen(state:String, screenClass:Class, assetState:String, cache:Boolean=true):void
		{
			regState(new ViewState(state, new ClassFactory(screenClass), assetState));
		}
		
		public function regDialog(state:String, dialogClass:Class, cache:Boolean=true):void
		{
			_dialogStack.regState(new ViewState(state, new ClassFactory(dialogClass), null));
		}
		
		public function regCloseNavigation(fromState:String):void
		{
			_closeNavigationState = fromState;
		}
		
		public function openDialog(name:String, data:Object=null):IDialog
		{
			if (currentState.instance is IScreen)
				return _dialogStack.show(name, data, assignScreen) as IDialog;
			else
				return _dialogStack.show(name, data) as IDialog;
		}
		
		private function assignScreen(view:IView):void
		{
			(currentState.instance as IScreen).deactivate();
			(view as IDialog).screen = currentState.instance as IScreen;
		}
		
		public function closeDialog(name:String):void
		{
			_dialogStack.hide(name);
			
			if (_dialogStack.numOpenedViews == 0 && currentState && currentState.instance is IScreen)
				(currentState.instance as IScreen).activate();
		}
		
		public function start():void
		{
			navigate(NavigationEvent.INITIALIZE, NavigationEvent.INITIALIZE);
		}
		
		public function getTopDialog():IDialog
		{
			return _dialogStack.topState ? _dialogStack.topState.instance as IDialog : null;
		}
		
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
		
		private function onDeactivate(event:flash.events.Event):void
		{
			navigate(NavigationEvent.DEACTIVATE);
		}
		
		private function onCloseDialog(e:NavigationEvent):void
		{
			if(e.data && e.data is String)
				_dialogStack.hide(e.data as String);
			else
				_dialogStack.hideTop();
			
			if (_dialogStack.numOpenedViews == 0 && currentState && currentState.instance is IScreen)
				(currentState.instance as IScreen).activate();
		}
		
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
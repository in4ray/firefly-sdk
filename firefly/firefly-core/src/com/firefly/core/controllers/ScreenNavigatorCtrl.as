package com.firefly.core.controllers
{
	import com.firefly.core.Firefly;
	import com.firefly.core.assets.AssetManager;
	import com.firefly.core.controllers.helpers.DialogProxy;
	import com.firefly.core.controllers.helpers.Navigation;
	import com.firefly.core.controllers.helpers.ViewState;
	import com.firefly.core.display.IDialog;
	import com.firefly.core.display.IScreenNavigator;
	import com.firefly.core.events.NavigationEvent;
	import com.firefly.core.utils.ClassFactory;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	public class ScreenNavigatorCtrl extends NavigatorCtrl
	{
		private var _splashClass:ClassFactory;
		private var _dialogStack:ViewStackCtrl;
		private var _dialogProxy:DialogProxy;
		
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
					openDialog(navigation.toState, data);
					return true;
				}
			}
			
			return super.navigate(trigger, data);
		}
		
		public function regSplash(splashClass:Class):void
		{
			_splashClass = new ClassFactory(splashClass);
		}
		
		public function regScreen(state:String, screenClass:Class, assetState:String, cache:Boolean=true):void
		{
			regState(new ViewState(state, new ClassFactory(screenClass), assetState, cache));
		}
		
		public function regDialog(state:String, dialogClass:Class, cache:Boolean=true):void
		{
			_dialogStack.regState(new ViewState(state, new ClassFactory(dialogClass), null, cache));
		}
		
		public function openDialog(name:String, data:Object=null):void
		{
			_dialogStack.show(name, data);
		}
		
		public function closeDialog(name:String):void
		{
			_dialogStack.hide(name);
		}
		
		public function start():void
		{
			navigate(NavigationEvent.INITIALIZE);
		}
		
		public function getTopDialog():IDialog
		{
			return _dialogStack.topState ? _dialogStack.topState.instance as IDialog : null;
		}
		
		private function onCloseDialog(e:NavigationEvent):void
		{
			if(e.data && e.data is String)
				_dialogStack.hide(e.data as String);
			else
				_dialogStack.hideTop();
		}
		
		private function onActivate(event:flash.events.Event):void
		{
			navigate(NavigationEvent.ACTIVATE);
		}
		
		private function onDeactivate(event:flash.events.Event):void
		{
			navigate(NavigationEvent.DEACTIVATE);
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.BACK)
			{	
				var navigated:Boolean
				var dialog:IDialog = getTopDialog();
				if(dialog)
				{
					dialog.onBack();
					_dialogStack.hideTop();
				}
				else
				{
					navigated = navigate(NavigationEvent.BACK);
				}
				
				if (navigated)
					event.preventDefault();
			}
		}
	}
}
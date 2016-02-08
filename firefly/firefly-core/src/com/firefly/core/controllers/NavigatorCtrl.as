package com.firefly.core.controllers
{
	import com.firefly.core.assets.AssetManager;
	import com.firefly.core.controllers.helpers.Navigation;
	import com.firefly.core.controllers.helpers.ViewState;
	import com.firefly.core.display.INavigator;
	import com.firefly.core.display.IView;
	import com.firefly.core.transitions.ITransition;
	
	import flash.utils.Dictionary;
	
	import starling.events.Event;

	public class NavigatorCtrl
	{
		protected var _navigations:Dictionary;
		protected var _navigator:INavigator;
		protected var _stack:ViewStackCtrl;
		protected var _assetManager:AssetManager;
		
		public function NavigatorCtrl(navigator:INavigator, assetManager:AssetManager)
		{
			_navigator = navigator;
			_navigations = new Dictionary;
			_assetManager = assetManager;
			_stack = new ViewStackCtrl(navigator);
		}
		
		public function get assetManager():AssetManager { return _assetManager; }
		public function get currentState():ViewState { return _stack.topState;	}
		public function get currentStateName():String { return currentState ? currentState.name : "*";	}
		
		public function regState(state:ViewState):void
		{
			_stack.regState(state);
		}
		
		public function regNavigation(trigger:String, fromState:String, toState:String, transition:ITransition=null):void
		{
			if(!_navigator.hasEventListener(trigger))
				_navigator.addEventListener(trigger, navigateHandler);
			
			_navigations[trigger + String.fromCharCode(31) + fromState] = new Navigation(trigger, fromState, toState, transition);
		}
		
		public function getNavigation(trigger:String, currentState:String):Navigation
		{
			var navigation:Navigation = _navigations[trigger + String.fromCharCode(31) + currentState];
			
			if(!navigation)
				navigation = _navigations[trigger + String.fromCharCode(31) + "*"];
			
			return navigation;
		}
		
		protected function navigateHandler(event:Event):void
		{
			navigate(event.type, event.data);
		}
		
		public function navigate(trigger:String, data:Object=null):Boolean
		{
			var navigation:Navigation = getNavigation(trigger, currentStateName);
			if(navigation)
			{
				if(navigation.transition)
					navigation.transition.transit(this, _stack.getState(navigation.toState), data);
				else
					navigateToState(navigation.toState, data);
				
				return true;
			}
			else
			{
				return false;
			}
		}
		
		public function navigateToState(toState:String, data:Object=null):void
		{
			_stack.hideTop();
			var viewState:ViewState = _stack.getState(toState);
			if(viewState)
				_assetManager.switchToStateName(viewState.assetState).then(_stack.show, toState, data);
		}
	
		public function addOverlay(overlay:IView):void
		{
			_stack.addOverlay(overlay);
		}
		
		public function removeOverlay(overlay:IView):void
		{
			_stack.removeOverlay(overlay);
		}
		
		public function getState(name:String):ViewState
		{
			return _stack.getState(name);
		}
	}
}
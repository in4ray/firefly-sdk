package com.firefly.core.controllers
{
	import com.firefly.core.assets.AssetManager;
	import com.firefly.core.controllers.helpers.Navigation;
	import com.firefly.core.controllers.helpers.ViewState;
	import com.firefly.core.display.IView;
	import com.firefly.core.display.IViewNavigator;
	import com.firefly.core.display.IViewStack;
	import com.firefly.core.transitions.ITransition;
	import com.firefly.core.utils.ClassFactory;
	
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	import starling.core.Starling;
	import starling.events.Event;
	
	public class ViewNavigatorCtrl
	{
		private var _viewNavigator:IViewNavigator;
		private var _navigations:Dictionary;
		private var _stack:ViewStackCtrl;
		private var _assetManager:AssetManager;
		
		public function ViewNavigatorCtrl(viewNavigator:IViewNavigator, assetManager:AssetManager)
		{
			_assetManager = assetManager;
			_viewNavigator = viewNavigator;
			_navigations = new Dictionary;
			_stack = new ViewStackCtrl(viewNavigator as IViewStack);
		}

		public function get assetManager():AssetManager { return _assetManager; }
		public function get viewNavigator():IViewNavigator { return _viewNavigator;	}
		public function get currentState():ViewState { return _stack.topState;	}
		public function get currentStateName():String { return currentState ? currentState.name : "*";	}
		public function get currentView():IView { return currentState ? currentState.instance : null;	}

		public function regView(name:String, factory:ClassFactory):void
		{
			_stack.regView(name, factory);
		}
		

		public function regState(state:ViewState):void
		{
			_stack.regState(state);
		}
		
		public function regNavigation(trigger:String, fromState:String, toState:String, transition:ITransition=null):void
		{
			_viewNavigator.addEventListener(trigger, navigateHandler);
			
			if(transition)
				transition.navigator = this;
			_navigations[trigger + String.fromCharCode(31) + fromState] = new Navigation(this, trigger, fromState, toState, transition);
		}
		
		protected function navigateHandler(event:Event):void
		{
			navigate(event.type, event.data);
		}
		
		public function navigate(trigger:String, data:Object=null):void
		{
			var navigation:Navigation = getNavigation(trigger);
			
			if(navigation)
			{
				if(navigation.transition)
					navigation.transition.transit(_stack.getState(navigation.toState), data);
				else
					navigateToState(navigation.toState, data);
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
		
		public function getNavigation(trigger:String):Navigation
		{
			var navigation:Navigation = _navigations[trigger + String.fromCharCode(31) + currentStateName];
			
			if(!navigation)
				navigation = _navigations[trigger + String.fromCharCode(31) + "*"];
			
			return navigation;
		}
	}
}
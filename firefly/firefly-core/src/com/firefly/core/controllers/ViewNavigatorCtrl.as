package com.firefly.core.controllers
{
	import com.firefly.core.controllers.helpers.Navigation;
	import com.firefly.core.controllers.helpers.ViewState;
	import com.firefly.core.display.INavigationView;
	import com.firefly.core.display.IViewNavigator;
	import com.firefly.core.utils.ClassFactory;
	
	import flash.utils.Dictionary;
	
	import starling.events.Event;
	
	public class ViewNavigatorCtrl
	{
		protected var _viewNavigator:IViewNavigator;
		protected var _views:Dictionary;
		protected var _navigations:Dictionary;
		protected var _currentState:String;
		protected var _currentView:INavigationView;
		
		public function ViewNavigatorCtrl(viewNavigator:IViewNavigator)
		{
			_viewNavigator = viewNavigator;
			_views = new Dictionary();
			_navigations = new Dictionary;
		}

		public function get viewNavigator():IViewNavigator { return _viewNavigator;	}

		public function regView(state:String, factory:ClassFactory):void
		{
			_views[state] = new ViewState(state, factory);
		}
		
		public function regNavigation(trigger:String, fromState:String, toState:String):void
		{
			_viewNavigator.addEventListener(trigger, navigateHandler);
			
			_navigations[trigger + String.fromCharCode(31) + fromState] = new Navigation(this, trigger, fromState, toState);
		}
		
		protected function navigateHandler(event:Event):void
		{
			var navigation:Navigation = _navigations[event.type + String.fromCharCode(31) + _currentState];
			
			if(!navigation)
				navigation = _navigations[event.type + String.fromCharCode(31) + "*"];
			
			if(navigation)
				navigate(navigation.toState, event.data);
		}
		
		public function navigate(toState:String, data:Object=null):void
		{
			removeCurrentView();
			
			var factory:ClassFactory = _views[toState].factory;
			if(factory)
			{
				var view:INavigationView = factory.newInstance();
				_currentState = toState;
				_viewNavigator.addView(view);
				view.show(data);
				_currentView = view;
			}
		}
		
		protected function removeCurrentView():void
		{
			if(_currentView)
			{
				_currentView.hide();
				_viewNavigator.removeView(_currentView);
				_currentView = null;
				_currentState = "*";
			}
		}
	}
}
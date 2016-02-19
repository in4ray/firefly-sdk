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
	import com.firefly.core.assets.AssetManager;
	import com.firefly.core.controllers.helpers.Navigation;
	import com.firefly.core.controllers.helpers.ViewState;
	import com.firefly.core.display.INavigator;
	import com.firefly.core.display.IView;
	import com.firefly.core.transitions.ITransition;
	
	import flash.utils.Dictionary;
	
	import starling.events.Event;

	/** The NavigatorCtrl is the controller which manages set of views in navigator, switches 
	 *  between view states the view using navigation transitions. 
	 * 
	 *  @see com.firefly.core.controllers.helpers.ViewState
	 *  @see com.firefly.core.controllers.helpers.Navigation
	 *  @see com.firefly.core.controllers.ViewStackCtrl
	 *  @see com.firefly.core.transitions.BasicTransition */	
	public class NavigatorCtrl
	{
		/** List if navigation. */		
		protected var _navigations:Dictionary;
		
		/** Navigator component. */	
		protected var _navigator:INavigator;
		
		/** View stack controller. */	
		protected var _stack:ViewStackCtrl;
		
		/** Asset manager. */	
		protected var _assetManager:AssetManager;
		
		/** Constructor.
		 *  @param navigator Instance navigaor component which contains views.
		 *  @param assetManager Instance of asset manager. */		
		public function NavigatorCtrl(navigator:INavigator, assetManager:AssetManager)
		{
			_navigator = navigator;
			_navigations = new Dictionary;
			_assetManager = assetManager;
			_stack = new ViewStackCtrl(navigator);
		}
		
		/** Asset manager. */		
		public function get assetManager():AssetManager { return _assetManager; }
		
		/** Current state. */
		public function get currentState():ViewState { return _stack.topState;	}
		
		/** Current state name. */
		public function get currentStateName():String { return currentState ? currentState.name : "*";	}
		
		/** This function register view state.
		 *  @param state The view state to register. */
		public function regState(state:ViewState):void
		{
			_stack.regState(state);
		}
		
		/** The function the registers navigation in navigator.
		 *  @param trigger Trigger event which should begin navigation.
		 *  @param fromState From which state should be navigation.
		 *  @param toState To which state should be navigation.
		 *  @param transition Transition which be used for navigation from screen to screen. */		
		public function regNavigation(trigger:String, fromState:String, toState:String, transition:ITransition=null):void
		{
			if(!_navigator.hasEventListener(trigger))
				_navigator.addEventListener(trigger, navigateHandler);
			
			_navigations[trigger + String.fromCharCode(31) + fromState] = new Navigation(trigger, fromState, toState, transition);
		}
		
		/** This function returns navigation by trigger event and curretn state.
		 *  @param trigger Trigger event of starting navigation.
		 *  @param currentState Current view state.
		 *  @return Instance of navigation. */
		public function getNavigation(trigger:String, currentState:String):Navigation
		{
			var navigation:Navigation = _navigations[trigger + String.fromCharCode(31) + currentState];
			
			if(!navigation)
				navigation = _navigations[trigger + String.fromCharCode(31) + "*"];
			
			return navigation;
		}
		
		/** The function does navigation from one view state to another view state.
		 *  @param trigger Trigger event of starting navigation.
		 *  @param data Some additional data which will be added to the view.
		 *  @return Status of navigation. Returns <code>false</code> when apropriate navigation isn't registered. */		
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
		
		/** The function does navigation to the defiened view state.
		 *  @param toState The state name.
		 *  @param data Some additional data which will be added to the view. */		
		public function navigateToState(toState:String, data:Object=null):void
		{
			_stack.hideTop();
			var viewState:ViewState = _stack.getState(toState);
			if(viewState)
				_assetManager.switchToStateName(viewState.assetState).then(_stack.show, toState, data);
		}

		/** The fucntion returns view state by name.
		 *  @param name View state name.
		 *  @return Instance of view state. */		
		public function getState(name:String):ViewState
		{
			return _stack.getState(name);
		}
		
		/** This function adds overlay for showing during app context is restoring.
		 *  @param overlay View overlay. This component should be the flash component 
		 *  whithout using any textures which uploaded to the GPU */
		public function addOverlay(overlay:IView):void
		{
			_stack.addOverlay(overlay);
		}
		
		/** This function removes overlay.
		 *  @param overlay View overlay should be removed. */
		public function removeOverlay(overlay:IView):void
		{
			_stack.removeOverlay(overlay);
		}
		
		/** @private
		 *  Invoke navigation by event.  */		
		protected function navigateHandler(event:Event):void
		{
			navigate(event.type, event.data);
		}
	}
}
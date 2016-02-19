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
	import com.firefly.core.controllers.helpers.ViewState;
	import com.firefly.core.display.IView;
	import com.firefly.core.display.IViewStack;
	import com.firefly.core.utils.ClassFactory;
	
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	import starling.core.Starling;

	/** The ViewStackCtrl is the controller which manages set of views in stack, switches 
	 *  between view states, shows, hides the view. 
	 * 
	 *  @see com.firefly.core.controllers.helpers.ViewState */	
	public class ViewStackCtrl
	{
		/** @private */		
		private var _max:int = 1;
		/** @private */	
		private var _views:Dictionary;
		/** @private */	
		private var _openedViews:Vector.<ViewState>;
		/** @private */	
		private var _viewStack:IViewStack;
		/** @private */	
		private var _overlay:IView;
		
		/** Constructor.
		 *  @param viewStack Instance of the view stack component.
		 *  @param max Maximum views which can be opened together. */		
		public function ViewStackCtrl(viewStack:IViewStack, max:int = 1)
		{
			_max = max;
			_viewStack = viewStack;
			_views = new Dictionary();
			_openedViews = new Vector.<ViewState>();
		}
		
		/** The number of opened views. */		
		public function get numOpenedViews():int { return _openedViews.length; }
		
		/** The top showed view state. */		
		public function get topState():ViewState
		{
			return _openedViews.length > 0 ? _openedViews[_openedViews.length-1] : null;
		}

		/** This function registers view state in view stack.
		 *  @param state View state. */		
		public function regState(state:ViewState):void
		{
			_views[state.name] = state;
		}
		
		/** This function registers view in the view stack and automatically creates view state.
		 *  @param name The name of the view state.
		 *  @param factory Class factory for creation view component.
		 *  @param cache Property that defines is view cacheable or not. */		
		public function regView(name:String, factory:ClassFactory, cache:Boolean = true):void
		{
			_views[name] = new ViewState(name, factory);
		}
		
		/** This function shows view by view state name.
		 *  @param name View state name.
		 *  @param data Some additional data which will be added to the view.
		 *  @return View component. */		
		public function show(name:String, data:Object = null):IView
		{
			var state:ViewState = _views[name];
			if(state)
			{
				var view:IView = _views[name].getInstance();
				if(view)
				{
					_viewStack.addView(view, _openedViews.length);
					
					if(_openedViews.length == _max)
						hideState(_openedViews[0]);
					
					_openedViews.push(state);
					
					view.viewData = data;
					view.show();
					
					return view;
				}
			}
			
			return null;
		}
		
		/** This function hides view by view state name.
		 *  @param name View state name.
		 *  @return View state. */		
		public function hide(name:String):ViewState
		{
			for each (var state:ViewState in _openedViews) 
			{
				if(state.name == name)
					return hideState(state);
			}
			
			return null; 
		}
		
		/** This function hides the top opened view.
		 *  @return View state. */		
		public function hideTop():ViewState
		{
			if(_openedViews.length > 0)
				return hideState(_openedViews[_openedViews.length-1]);
			
			return null;
		}
		
		/** This function hides all opened views. */		
		public function hideAll():void
		{
			while(_openedViews.length > 0)
			{
				hideState(_openedViews[_openedViews.length-1]);
			}
		}
		
		/** This function hides showed view state.
		 *  @return View state. */		
		protected function hideState(state:ViewState):ViewState
		{
			var index:int = _openedViews.indexOf(state);
			if(index > -1)
				_openedViews.splice(index, 1);
			
			_viewStack.removeView(state.instance);
			state.instance.hide();
			
			return state;
		}
		
		/** This function returns the view state by name.
		 *  @return View state. */
		public function getState(name:String):ViewState
		{
			return _views[name];
		}
		
		/** This function adds overlay for showing during app context is restoring.
		 *  @param overlay View overlay. This component should be the flash component 
		 *  whithout using any textures which uploaded to the GPU */
		public function addOverlay(overlay:IView):void
		{
			if(_overlay)
				removeOverlay(_overlay);
			
			_overlay = overlay;
			if(overlay is Sprite)
			{
				(overlay as Sprite).width = Firefly.current.stageWidth;
				(overlay as Sprite).height = Firefly.current.stageHeight;
				Starling.current.nativeOverlay.addChild(overlay as Sprite);
			}
			else
			{
				_viewStack.addView(overlay);
			}
			
			overlay.show();
		}
		
		/** This function removes overlay.
		 *  @param overlay View overlay should be removed. */
		public function removeOverlay(overlay:IView):void
		{
			if(overlay is Sprite && (overlay as Sprite).parent)
				Starling.current.nativeOverlay.removeChild(overlay as Sprite);
			else
				_viewStack.removeView(overlay);
			
			overlay.hide();
			_overlay = null;
		}
	}
}
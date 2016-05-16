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
	import com.firefly.core.display.INavigator;
	import com.firefly.core.display.IView;
	import com.firefly.core.utils.ClassFactory;
	
	/** The ViewNavigatorCtrl is the controller which manages navigations between views in one screen. */	
	public class ViewNavigatorCtrl extends NavigatorCtrl
	{
		/** Constructor.
		 *  @param viewNavigator Instance of view navigator component.
		 *  @param assetManager Instance of asset manager. */		
		public function ViewNavigatorCtrl(viewNavigator:INavigator, assetManager:AssetManager)
		{
			super(viewNavigator, assetManager);
		}

		/** View navigator component. */		
		public function get viewNavigator():INavigator { return _navigator;	}
		
		/** Current view which is displayed in the view navigator. */		
		public function get currentView():IView { return currentState ? currentState.instance : null;	}

		/** Register view 
		 *  @param name View state name.
		 *  @param factory Class factory for creation view component. */		
		public function regView(name:String, factory:ClassFactory):void
		{
			_stack.regView(name, factory);
		}
	}
}
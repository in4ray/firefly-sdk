package com.firefly.core.controllers
{
	import com.firefly.core.assets.AssetManager;
	import com.firefly.core.display.INavigator;
	import com.firefly.core.display.IView;
	import com.firefly.core.utils.ClassFactory;
	
	public class ViewNavigatorCtrl extends NavigatorCtrl
	{
		
		public function ViewNavigatorCtrl(viewNavigator:INavigator, assetManager:AssetManager)
		{
			super(viewNavigator, assetManager);
		}

		public function get viewNavigator():INavigator { return _navigator;	}
		public function get currentView():IView { return currentState ? currentState.instance : null;	}

		public function regView(name:String, factory:ClassFactory):void
		{
			_stack.regView(name, factory);
		}
	}
}
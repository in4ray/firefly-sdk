// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.controllers.helpers
{
	import com.firefly.core.display.IDialog;
	import com.firefly.core.display.INavigator;
	import com.firefly.core.display.IScreenNavigator;
	import com.firefly.core.display.IView;

	/** The DialogProxy class uses for navigating dialogs inside screen navigator. */
	public class DialogProxy implements INavigator
	{
		/** @private */		
		private var _navigator:IScreenNavigator;
		
		/** Constructor.
		 *  @param navigator Screnn navigator component. */		
		public function DialogProxy(navigator:IScreenNavigator)
		{
			_navigator = navigator;
		}
		
		/** Registers an event listener at a certain object.
		 *  @param type Event type.
		 *  @param listener Function which be called when event was invoked. */		
		public function addEventListener(type:String, listener:Function):void
		{
			_navigator.addEventListener(type, listener);
		}
		
		
		/** If called with one argument, figures out if there are any listeners registered for the given event 
		 *  type. If called with two arguments, also determines if a specific listener is registered.
		 *  @param type Event type.
		 *  @param listener Function which be called when event was invoked. */		
		public function hasEventListener(type:String, listener:Function=null):Boolean
		{
			return _navigator.hasEventListener(type);
		}
		
		/** This function adds dialog to the navigator.
		 *  @param dailog Instance of the dialog.
		 *  @param index Depth. */		
		public function addView(view:IView, index:int=-1):void
		{
			_navigator.addDialog(view as IDialog);
		}
		
		/** This function removes dialog from the navigator.
		 *  @param dailog Instance of the dialog. */
		public function removeView(view:IView):void
		{
			_navigator.removeView(view);
		}
		
	}
}
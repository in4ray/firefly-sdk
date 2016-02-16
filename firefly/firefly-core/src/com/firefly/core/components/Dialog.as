// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.components
{
	import com.firefly.core.display.IDialog;
	import com.firefly.core.effects.Scale;
	
	/** The Dialog class you can extend for creating your own dialog which can be added 
	 *  to the screen navigator. This gives you the ability to process automatically 
	 *  showing up and hiding the dialog. */	
	public class Dialog extends View implements IDialog
	{
		/** Constructor. */		
		public function Dialog()
		{
			super();
		}
		
		/** @inheritDoc */		
		override public function show():void
		{
			new Scale(this, .2, 1, 0.1).play();
		}

		/** This function calls when dialog is active and user clicks back 
		 *  button on the device. */		
		public function onBack():void { }
	}
}
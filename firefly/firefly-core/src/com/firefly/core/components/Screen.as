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
	import com.firefly.core.Firefly;
	import com.firefly.core.display.IScreen;
	
	/** The Screen is container which describes one single screen. You can extend this class to add 
	 *  your own view components to the screen container which allow you automatically switching 
	 *  between different screens. By default size of the screen is the same as Stage. 
	 *  
	 * @see com.firefly.core.components.ScreenNavigator
	 * @see com.firefly.core.layouts.Layout
	 * @see com.firefly.core.layouts.constraints.LayoutConstraint */
	public class Screen extends View implements IScreen
	{
		/** Constructor. */		
		public function Screen()
		{
			super();
			
			width = Firefly.current.stageWidth;
			height = Firefly.current.stageHeight;
		}
		
		/** @inheritDoc */		
		public function activate():void { }
		
		/** @inheritDoc */		
		public function deactivate():void { }
	}
}
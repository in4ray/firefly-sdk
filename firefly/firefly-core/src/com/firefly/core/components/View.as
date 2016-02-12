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
	import com.firefly.core.display.IView;
	
	/** The View class is abstract class you can extend to add your own view components to 
	 *  the view stack component.
	 * 
	 *  @see com.firefly.core.layouts.Layout
	 *  @see com.firefly.core.layouts.constraints.LayoutConstraint */	
	public class View extends Component implements IView
	{
		/** @inheritDoc */		
		public function set viewData(data:Object):void { }
		
		/** @inheritDoc */
		public function show():void { }
		
		/** @inheritDoc */
		public function hide():void { }
	}
}
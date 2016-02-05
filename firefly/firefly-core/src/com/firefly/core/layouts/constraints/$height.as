// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.layouts.constraints
{
	/** Global function that returns layout constraint that sets height of target.
	 *  @param value Layout value
	 *  @param keepAspectRatio Flag that indicates whether layout should calculate 
	 *         width to keep original aspect ratio.
	 *  @return Layout constraint. */	
	public function $height(value:Number, keepAspectRatio:Boolean=false):ILayoutUnits
	{
		return new ConstraintHeight(value, keepAspectRatio, $height);
	}
}

import com.firefly.core.layouts.constraints.LayoutConstraint;
import com.firefly.core.layouts.helpers.LayoutContext;
import com.firefly.core.layouts.helpers.LayoutElement;

class ConstraintHeight extends LayoutConstraint
{
	private var _keepAspectRatio:Boolean;
	
	public function ConstraintHeight(value:Number, keepAspectRatio:Boolean, globalFunc:Function)
	{
		super(value, SIZE, globalFunc);
		_keepAspectRatio = keepAspectRatio;	
	}
	
	override public function layout(context:LayoutContext, element:LayoutElement):void
	{
		var ratio:Number = 1;
		
		if(_keepAspectRatio)
			ratio = element.width/element.height;
		
		var h:Number =  context.layoutToRealByY(value, units);
		if (h == 0)
			return;
		
		element.height = h;
		
		if(_keepAspectRatio)
			element.width = element.height* ratio;
	}
}
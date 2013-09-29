// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.layouts.constraints
{
	import com.firefly.core.layouts.constraints.ILayoutUnits;

	/** Global function that returns layout constraint that sets width of target.
	 *  @param value Layout value
	 *  @param keepAspectRatio Flag that indicates whether layout should calculate 
	 *         heigth to keep original aspect ratio.
	 *  @return Layout constraint. */
	public function $width(value:Number, keepAspectRatio:Boolean=false):ILayoutUnits
	{
		return new ConstraintWidth(value, keepAspectRatio, $width);
	}
}

import com.firefly.core.layouts.constraints.LayoutConstraint;
import com.firefly.core.layouts.helpers.LayoutContext;
import com.firefly.core.layouts.helpers.LayoutElement;

class ConstraintWidth extends LayoutConstraint
{
	private var _keepAspectRatio:Boolean;
	
	public function ConstraintWidth(value:Number, keepAspectRatio:Boolean, globalFunc:Function)
	{
		super(value, SIZE, globalFunc);
		_keepAspectRatio = keepAspectRatio;	
	}
	
	override public function layout(context:LayoutContext, element:LayoutElement):void
	{
		var ratio:Number = 1;
		
		if(_keepAspectRatio)
			ratio = element.height/element.width;
		
		element.width = context.layoutToRealByX(value, units);
		
		if(_keepAspectRatio)
			element.height = element.width* ratio;
	}
}
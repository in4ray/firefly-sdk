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
	/** Global function that returns layout constraint that sets position by Y-Axis for target.
	 *  @param value Layout value on design coordinate system.
	 *  @return Layout constraint. */
	public function $y(value:Number):ILayoutUnits
	{
		return new ConstraintY(value, $y);
	}
}

import com.firefly.core.layouts.constraints.LayoutConstraint;
import com.firefly.core.layouts.helpers.LayoutContext;
import com.firefly.core.layouts.helpers.LayoutElement;

class ConstraintY extends LayoutConstraint
{
	public function ConstraintY(value:Number, globalFunc:Function)
	{
		super(value, POSITION, globalFunc);	
	}
	
	override public function layout(context:LayoutContext, element:LayoutElement):void
	{
		element.y = context.layoutToRealByY(value, units, true);
	}
}
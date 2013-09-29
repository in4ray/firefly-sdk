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
	/** Global function that returns layout constraint that sets pivot by Y-Axis for target.
	 *  @param value Layout value
	 *  @return Layout constraint. */
	public function $pivotY(value:Number):ILayoutUnits
	{
		return new ConstraintPivotY(value, $pivotY);
	}
}

import com.firefly.core.layouts.constraints.LayoutConstraint;
import com.firefly.core.layouts.helpers.LayoutContext;
import com.firefly.core.layouts.helpers.LayoutElement;

class ConstraintPivotY extends LayoutConstraint
{
	public function ConstraintPivotY(value:Number, globalFunc:Function):void
	{
		super(value, PIVOTS, globalFunc);
	}
	
	override public function layout(context:LayoutContext, element:LayoutElement):void
	{
		elementContext.height = element.height;
		
		element.pivotY = elementContext.layoutToRealByY(value, units);
	}
}
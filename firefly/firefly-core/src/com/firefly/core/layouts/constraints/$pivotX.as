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

	/** Global function that returns layout constraint that sets pivot by X-Axis for target.
	 *  @param value Layout value
	 *  @return Layout constraint. */
	public function $pivotX(value:Number):ILayoutUnits
	{
		return new ConstraintPivotX(value, $pivotX);
	}
}

import com.firefly.core.layouts.constraints.LayoutConstraint;
import com.firefly.core.layouts.helpers.LayoutContext;
import com.firefly.core.layouts.helpers.LayoutElement;

class ConstraintPivotX extends LayoutConstraint
{
	public function ConstraintPivotX(value:Number, globalFunc:Function):void
	{
		super(value, PIVOTS, globalFunc);
	}
	
	override public function layout(context:LayoutContext, element:LayoutElement):void
	{
		elementContext.width = element.width;
		
		element.pivotX = elementContext.layoutToRealByX(value, units);
	}
}